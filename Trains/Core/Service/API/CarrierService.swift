import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

// MARK: - Typealiases
typealias CarrierResponse = Components.Schemas.CarrierResponse

// MARK: - Protocol
protocol CarrierServiceProtocol {
    func getCarrierInfo(
        apikey: String,
        code: String,
        system: String?,
        lang: String?,
        format: String?
    ) async throws -> CarrierResponse
}

// MARK: - Service
final class CarrierService: CarrierServiceProtocol {
    // MARK: - Properties
    private let client: Client
    
    // MARK: - Init
    init(client: Client) {
        self.client = client
    }
    
    // MARK: - Public
    func getCarrierInfo(
        apikey: String,
        code: String,
        system: String? = nil,
        lang: String? = nil,
        format: String? = nil
    ) async throws -> CarrierResponse {
        let response = try await client.getCarrierInfo(query: .init(
            apikey: apikey,
            code: code,
            system: system,
            lang: lang,
            format: format
        ))
        return try response.ok.body.json
    }
}
