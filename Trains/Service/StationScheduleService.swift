import OpenAPIRuntime
import OpenAPIURLSession

// MARK: - Typealiases
typealias StationSchedule = Components.Schemas.ScheduleResponse

// MARK: - Protocol
protocol StationScheduleServiceProtocol {
    func getStationSchedule(
        station: String,
        date: String?,
        lang: String?,
        format: String?,
        transportTypes: String?,
        event: String?,
        direction: String?,
        system: String?,
        resultTimezone: String?
    ) async throws -> StationSchedule
}

final class StationScheduleService: StationScheduleServiceProtocol {
    
    // MARK: - Private Properties
    private let client: Client
    private let apiKey: String
    
    // MARK: - Initialization
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    // MARK: - Public Method
    func getStationSchedule(
        station: String,
        date: String? = nil,
        lang: String? = nil,
        format: String? = "json",
        transportTypes: String? = nil,
        event: String? = nil,
        direction: String? = nil,
        system: String? = nil,
        resultTimezone: String? = nil
    ) async throws -> StationSchedule {
        let response = try await client.getStationSchedule(query: .init(
            apikey: apiKey,
            station: station,
            lang: lang,
            format: format,
            date: date,
            transport_types: transportTypes,
            event: event,
            direction: direction,
            system: system,
            result_timezone: resultTimezone
        ))
        return try response.ok.body.json
    }
}
