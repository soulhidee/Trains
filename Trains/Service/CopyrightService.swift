import OpenAPIRuntime
import OpenAPIURLSession

// MARK: - Typealiases
typealias Copyright = Components.Schemas.Copyright

// MARK: - Protocol
protocol CopyrightServiceProtocol {
    func getCopyright(format: String) async throws -> Copyright
}

// MARK: - Service Implementation
final class CopyrightService: CopyrightServiceProtocol {
    
    // MARK: - Private Properties
    private let client: Client
    private let apiKey: String?
    
    // MARK: - Initialization
    init(client: Client, apiKey: String?) {
        self.client = client
        self.apiKey = apiKey
    }
    
    // MARK: - Public Methods
    func getCopyright(format: String = "json") async throws -> Copyright {
        let response = try await client.getCopyright(query: .init(
            apikey: apiKey,
            format: format
        ))
        return try response.ok.body.json
    }
}

