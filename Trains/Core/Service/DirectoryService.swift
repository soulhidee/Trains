import Foundation

struct DirectoryCity: Hashable, Sendable {
    let title: String
}

struct DirectoryStation: Hashable, Sendable {
    let title: String
    let yandexCode: String?
}

extension String {
    var containsRussianLetters: Bool {
        range(of: "[А-Яа-яЁё']", options: .regularExpression) != nil
    }
}

actor DirectoryService {
    private let apikey: String
    private var cachedCities: [DirectoryCity]?
    private var cachedCountries: Data?
    private var loadingTask: Task<[DirectoryCity], Error>?
    private var countriesLoadingTask: Task<Data, Error>?
    
    init(apikey: String) {
        self.apikey = apikey
    }
    
    func fetchAllCities() async throws -> [DirectoryCity] {
        if let cached = cachedCities { return cached }
        if let task = loadingTask { return try await task.value }
        
        let task = Task { () throws -> [DirectoryCity] in
            let data = try await loadCountriesData()
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            let countries = json?["countries"] as? [[String: Any]] ?? []
            
            var cities = Set<String>()
            for country in countries {
                let regions = country["regions"] as? [[String: Any]] ?? []
                for region in regions {
                    let settlements = region["settlements"] as? [[String: Any]] ?? []
                    for settlement in settlements {
                        if let title = settlement["title"] as? String,
                           !title.isEmpty,
                           title.containsRussianLetters {
                            cities.insert(title)
                        }
                    }
                }
            }
            
            let result = cities.sorted().map { DirectoryCity(title: $0) }
            return result
        }
        
        self.loadingTask = task
        let result = try await task.value
        self.cachedCities = result
        return result
    }
    
    func fetchStations(inCityTitle cityTitle: String) async throws -> [DirectoryStation] {
        let trimmed = cityTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return [] }
        
        let data = try await loadCountriesData()
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        let countries = json?["countries"] as? [[String: Any]] ?? []
        
        var result: [DirectoryStation] = []
        let target = normalize(trimmed)
        
        for country in countries {
            let regions = country["regions"] as? [[String: Any]] ?? []
            for region in regions {
                let settlements = region["settlements"] as? [[String: Any]] ?? []
                for settlement in settlements {
                    let title = (settlement["title"] as? String) ?? ""
                    guard normalize(title) == target else { continue }
                    
                    let stations = settlement["stations"] as? [[String: Any]] ?? []
                    for station in stations {
                        let transportType = (station["transport_type"] as? String) ?? ""
                        guard transportType == "train" else { continue }
                        
                        let stationTitle = (station["title"] as? String) ?? ""
                        let codes = station["codes"] as? [String: Any]
                        let yandexCode = codes?["yandex_code"] as? String
                        
                        guard let code = yandexCode, !code.isEmpty else { continue }
                        guard !stationTitle.isEmpty else { continue }
                        
                        result.append(DirectoryStation(title: stationTitle, yandexCode: code))
                    }
                }
            }
        }
        
        var seen = Set<String>()
        var unique: [DirectoryStation] = []
        for station in result {
            if seen.insert(station.title).inserted {
                unique.append(station)
            }
        }
        
        return unique.sorted { $0.title < $1.title }
    }
    
    // MARK: - Private helpers
    private func loadCountriesData() async throws -> Data {
        if let cached = cachedCountries { return cached }
        if let task = countriesLoadingTask { return try await task.value }
        
        let task = Task { () throws -> Data in
            let url = try makeURL()
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        }
        
        self.countriesLoadingTask = task
        let result = try await task.value
        self.cachedCountries = result
        return result
    }
    
    private func normalize(_ value: String) -> String {
        value
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "-", with: "")
            .lowercased()
    }
    
    private func makeURL() throws -> URL {
        var components = URLComponents(string: "https://api.rasp.yandex.net/v3.0/stations_list/")!
        components.queryItems = [
            URLQueryItem(name: "apikey", value: apikey),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "lang", value: "ru_RU")
        ]
        guard let url = components.url else { throw URLError(.badURL) }
        return url
    }
}
