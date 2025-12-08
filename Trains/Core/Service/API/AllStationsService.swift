import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

// MARK: - Protocol
protocol AllStationsServiceProtocol {
    func getAllStations(
        apikey: String,
        lang: String?,
        format: String?
    ) async throws -> String
}

// MARK: - Service
final class AllStationsService: AllStationsServiceProtocol {
    // MARK: - Properties
    private let client: Client
    
    // MARK: - Init
    init(client: Client) {
        self.client = client
    }
    
    // MARK: - Public
    func getAllStations(
        apikey: String,
        lang: String? = nil,
        format: String? = nil
    ) async throws -> String {
        let output = try await client.getAllStations(query: .init(
            apikey: apikey,
            lang: lang,
            format: format
        ))
        
        switch output {
        case .ok(let ok):
            switch ok.body {
            case .html(let body):
                var collected = Data()
                for try await chunk in body {
                    collected.append(contentsOf: chunk)
                }
                return String(data: collected, encoding: .utf8) ?? ""
            }
        default:
            throw NSError(
                domain: "AllStationsService",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Non-200 response"]
            )
        }
    }
}
