import OpenAPIRuntime
import OpenAPIURLSession

// MARK: - Typealiases
typealias NearestStations = Components.Schemas.Stations

// MARK: - Protocol
protocol NearestStationsServiceProtocol {
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
}

// MARK: - Service Implementation
final class NearestStationsService: NearestStationsServiceProtocol {
    
    // MARK: - Private Properties
    private let client: Client
    private let apiKey: String
    
    // MARK: - Initialization
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    // MARK: - Public Methods
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
        let response = try await client.getNearestStations(query: .init(
            apikey: apiKey,
            lat: lat,
            lng: lng,
            distance: distance
        ))
        return try response.ok.body.json
    }
}
