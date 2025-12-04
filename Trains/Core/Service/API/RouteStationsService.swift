import OpenAPIRuntime
import OpenAPIURLSession

// MARK: - Typealiases
typealias RouteStations = Components.Schemas.ThreadStationsResponse

// MARK: - Protocol
protocol RouteStationsServiceProtocol {
    func getRouteStations(
        uid: String,
        from: String?,
        to: String?,
        format: String?,
        lang: String?,
        date: String?,
        showSystems: String?
    ) async throws -> RouteStations
}

// MARK: - Service Implementation
final class RouteStationsService: RouteStationsServiceProtocol {
    
    // MARK: - Private Properties
    private let client: Client
    private let apiKey: String
    
    // MARK: - Initialization
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    // MARK: - Public Method
    func getRouteStations(
        uid: String,
        from: String? = nil,
        to: String? = nil,
        format: String? = nil,
        lang: String? = nil,
        date: String? = nil,
        showSystems: String? = nil
    ) async throws -> RouteStations {
        let response = try await client.getRouteStations(query: .init(
            apikey: apiKey,
            uid: uid,
            from: from,
            to: to,
            format: format,
            lang: lang,
            date: date,
            show_systems: showSystems
        ))
        return try response.ok.body.json
    }
}
