import OpenAPIRuntime
import OpenAPIURLSession

// MARK: - Typealiases
typealias Carrier = Components.Schemas.CarrierResponse

// MARK: - Protocol
protocol CarrierServiceProtocol {
    func getCarrierInfo(code: String, system: String?) async throws -> Carrier
}

final class CarrierService: CarrierServiceProtocol {
    // MARK: - Private Properties
    private let client: Client
    private let apiKey: String
    
    // MARK: - Initialization
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    // MARK: - Public Methods
    func getCarrierInfo(code: String, system: String? = nil) async throws -> Carrier {
        let response = try await client.getCarrierInfo(query: .init(
            apikey: apiKey,
            code: code,
            system: system
            
        ))
        return try response.ok.body.json
    }
}
