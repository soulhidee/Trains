import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

@globalActor
actor NetworkManager {
    static let shared = NetworkManager()
    
    private let client: Client
    private let searchService: ScheduleSearchService
    private let carrierService: CarrierService
    private let allStationService: AllStationsService
    
    private init() {
        let client = Client(
            serverURL: URL(string: "https://api.rasp.yandex.net") ?? {
                fatalError("Критическая ошибка: невалидный базовый URL API Яндекс.Расписаний")
            }(),
            transport: URLSessionTransport()
        )
        
        self.client = client
        self.carrierService = CarrierService(client: client)
        self.allStationService = AllStationsService(client: client)
        self.searchService = ScheduleSearchService(client: client, apiKey: Secrets.apiKey)
    }
    
    // MARK: - Search
    func getSegments(
        from: String,
        to: String,
        date: String? = nil,
        transport_types: String? = nil,
        limit: Int? = nil,
        offset: Int? = nil
    ) async throws -> Components.Schemas.Segments {
        try await searchService.getScheduleBetweenStations(
            from: from,
            to: to,
            date: date ?? Date().yyyyMMdd,
            transportTypes: transport_types,
            limit: limit
        )
    }
    
    // MARK: - Carrier
    func getCarrierInfo(
        code: String,
        system: String? = nil
    ) async throws -> CarrierResponse {
        try await carrierService.getCarrierInfo(
            apikey: Secrets.apiKey,
            code: code,
            system: system
        )
    }
    
    // MARK: - Raw HTML
    func getAllStationsRawHTML(
        lang: String? = nil,
        format: String? = nil
    ) async throws -> String {
        try await allStationService.getAllStations(
            apikey: Secrets.apiKey,
            lang: lang,
            format: format
        )
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
