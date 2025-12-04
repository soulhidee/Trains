import Foundation

struct DirectoryCity: Hashable, Sendable {
    let title: String
}

actor DirectoryService {
    private let apikey: String
    private var cachedCities: [DirectoryCity]?
    private var loadingTask: Task<[DirectoryCity], Error>?

    init(apikey: String) {
        self.apikey = apikey
    }

    func fetchAllCities() async throws -> [DirectoryCity] {
        if let cached = cachedCities { return cached }
        if let task = loadingTask { return try await task.value }
        
        let task = Task { () throws -> [DirectoryCity] in
            let url = try makeURL()
            let (data, _) = try await URLSession.shared.data(from: url)
            let json = try JSONSerialization.jsonObject(with: data) as?  [String: Any]
            let countries = json?["countries"] as?  [[String: Any]] ?? []
            
            var cities = Set<String>()
            for country in countries {
                let regions = country["regions"] as? [[String: Any]] ?? []
                for region in regions {
                    let settlements = region["settlements"] as? [[String: Any]] ?? []
                    for settlement in settlements {
                        if let title = settlement["title"] as? String, !title.isEmpty {
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

    private func makeURL() throws -> URL {
        var components = URLComponents(string: "https://api.rasp.yandex.net/v3. 0/stations_list/")!
        components.queryItems = [
            URLQueryItem(name: "apikey", value: apikey),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "lang", value: "ru_RU")
        ]
        guard let url = components.url else { throw URLError(.badURL) }
        return url
    }
}
