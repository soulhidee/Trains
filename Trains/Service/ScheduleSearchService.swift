import OpenAPIRuntime
import OpenAPIURLSession


// MARK: - Typealiases
typealias ScheduleSearch = Components.Schemas.Segments


// MARK: - Protocol
protocol ScheduleSearchServiceProtocol {
    func getScheduleBetweenStations(
        from fromStation: String,
        to toStation: String,
        date: String,
        transportTypes: String?,
        limit: Int?
    ) async throws -> ScheduleSearch
}

final class ScheduleSearchService: ScheduleSearchServiceProtocol {
    
    // MARK: - Private Properties
    private let client: Client
    private let apiKey: String
    
    // MARK: - Initialization
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    // MARK: - Public Methods
    func getScheduleBetweenStations(
        from fromStation: String,
        to toStation: String,
        date: String,
        transportTypes: String? = nil,
        limit: Int? = nil
    ) async throws -> ScheduleSearch {
        let response = try await client.getScheduleBetweenStations(query: .init(
            apikey: apiKey,
            from: fromStation,
            to: toStation,
            format: nil,
            lang: nil,
            date: date,
            transport_types: transportTypes,
            offset: nil,
            limit: limit,
            result_timezone: nil,
            transfers: nil
        ))
        return try response.ok.body.json
    }
}
