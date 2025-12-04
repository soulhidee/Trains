import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

@globalActor
actor NetworkManager {
    static let shared = NetworkManager()
    
    private let client: Client
    private let searchService: ScheduleSearchService
    private let carrierService: CarrierService
    private let allStationService: AllStationsService
    
    private init() {
        let client = Client(
            serverURL: URL(string: "https://api.rasp.yandex.net")!,
            transport: URLSessionTransport()
        )
        
        self.client = client
        
        self.carrierService = CarrierService(client: client)
        self.allStationService = AllStationsService(client: client)
        
        self.searchService = ScheduleSearchService(
            client: client,
            apiKey: Secrets.apiKey
        )
    }
}
