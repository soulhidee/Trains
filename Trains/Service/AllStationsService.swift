import OpenAPIRuntime
import Foundation
import OpenAPIURLSession

// MARK: - Typealiases
typealias AllStations = Components.Schemas.AllStationsResponse

// MARK: - Protocol
protocol AllStationsServiceProtocol {
    func getAllStations(limit: Int?) async throws -> AllStations
}

// MARK: - Service Implementation
final class AllStationsService: AllStationsServiceProtocol {
    
    // MARK: - Private Properties
    private let client: Client
    private let apiKey: String
    
    // MARK: - Initialization
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    // MARK: - Public Methods
    func getAllStations(limit: Int? = nil) async throws -> AllStations {
        let response = try await client.getAllStations(query: .init(apikey: apiKey))
        
        let responseBody = try response.ok.body.html
        
        let limit = 50 * 1024 * 1024
        var fullData = try await Data(collecting: responseBody, upTo: limit)
        
        let allStations = try JSONDecoder().decode(AllStations.self, from: fullData)
        
        return allStations
    }
}

