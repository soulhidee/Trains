import OpenAPIRuntime
import OpenAPIURLSession

// MARK: - Typealiases
typealias Carrier = Components.Schemas.CarrierResponse

protocol CarrierServiceProtocol {
    func getCarrierInfo(code: String, system: String?) async throws -> Carrier
}


final class CarrierService: CarrierServiceProtocol {
    private let client: Client
    private let apiKey: String
    
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getCarrierInfo(code: String, system: String? = nil) async throws -> Carrier {
        let response = try await client.getCarrierInfo(query: .init(
            apikey: apiKey,
            code: code,
            system: system
            
        ))
        return try response.ok.body.json
    }
}
