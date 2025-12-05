import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

@globalActor
actor APIClient {
    static let shared = APIClient()
    
    private let client: Client
    private let searchService: SearchService
    private let carrierService: CarrierService
    private let allStationService: AllStationsService
    private let directoryService: DirectoryService
    
    private init() {
        let client = Client(
            serverURL: URL(string: "https://api.rasp.yandex.net") ?? {
                fatalError("Критическая ошибка: невалидный базовый URL API Яндекс. Расписаний")
            }(),
            transport: URLSessionTransport()
        )
        
        self.client = client
        self.carrierService = CarrierService(client: client)
        self.allStationService = AllStationsService(client: client)
        self.searchService = SearchService(client: client)
        self.directoryService = DirectoryService(apikey: Secrets.apiKey)
    }
    
    // MARK: - Search
    func getSegments(
        apikey: String,
        from: String,
        to: String,
        format: String? = nil,
        lang: String? = nil,
        date: String? = nil,
        transport_types: String? = nil,
        offset: Int? = nil,
        limit: Int? = nil,
        result_timezone: String? = nil,
        transfers: Bool? = nil
    ) async throws -> Segments {
        try await searchService.getSegments(
            apikey: apikey,
            from: from,
            to: to,
            format: format,
            lang: lang,
            date: date,
            transport_types: transport_types,
            offset: offset,
            limit: limit,
            result_timezone: result_timezone,
            transfers: transfers
        )
    }
    
    // MARK: - Carrier
    func getCarrierInfo(
        apikey: String,
        code: String,
        system: String? = nil,
        lang: String? = nil,
        format: String? = nil
    ) async throws -> CarrierResponse {
        try await carrierService.getCarrierInfo(
            apikey: apikey,
            code: code,
            system: system,
            lang: lang,
            format: format
        )
    }
    
    // MARK: - Raw HTML
    func getAllStationsRawHTML(
        lang: String?  = nil,
        format: String? = nil
    ) async throws -> String {
        try await allStationService.getAllStations(
            apikey: Secrets.apiKey,
            lang: lang,
            format: format
        )
    }
    
    // MARK: - Directory (Cities)
    func fetchAllCities(apikey: String) async throws -> [DirectoryCity] {
        let directory = DirectoryService(apikey: apikey)
        return try await directory.fetchAllCities()
    }
    
    // MARK: - Directory (Stations)
    func fetchStations(inCityTitle cityTitle: String, apikey: String) async throws -> [DirectoryStation] {
        let directory = DirectoryService(apikey: apikey)
        return try await directory.fetchStations(inCityTitle: cityTitle)
    }
}

// MARK: - Helper
private extension Date {
    var yyyyMMdd: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: self)
    }
}
