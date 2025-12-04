import OpenAPIRuntime
import OpenAPIURLSession

// MARK: - Typealiases
typealias NearestCity = Components.Schemas.NearestCityResponse

// MARK: - Protocol
protocol NearestSettlementServiceProtocol {
    func getNearestCity(lat: Double, lng: Double, distance: Int) async throws -> NearestCity
}

// MARK: - Service Implementation
final class NearestSettlementService: NearestSettlementServiceProtocol {
    
    // MARK: - Private Properties
    private let client: Client
    private let apikey: String
    
    // MARK: - Initialization
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    // MARK: - Public Methods
    func getNearestCity(lat: Double, lng: Double, distance: Int) async throws -> NearestCity {
        let response = try await client.getNearestCity(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng,
            distance: distance
        ))
        return try response.ok.body.json
    }
}
