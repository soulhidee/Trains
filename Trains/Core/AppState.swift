import Foundation
import Combine

@MainActor
final class AppState: ObservableObject {
    // MARK: - Singleton
    static let shared = AppState()
    
    // MARK: - Published Properties
    @Published var isDataLoaded = false
    
    // MARK: - Private Properties
    private var directoryService: DirectoryService?
    
    // MARK: - Initialization
    private init() {}
    
    // MARK: - Data Loading
    func loadDataIfNeeded() async {
        guard directoryService == nil else { return }
        
        print("🔄 Загружаем данные первый раз...")
        
        let service = DirectoryService(apikey: Secrets.apiKey)
        
        do {
            _ = try await service.fetchAllCities()
            print("✅ Данные загружены и закэшированы в памяти")
            
            directoryService = service
            isDataLoaded = true
        } catch {
            print("❌ Ошибка загрузки: \(error)")
        }
    }
    
    // MARK: - Accessors
    func getService() -> DirectoryService? {
        return directoryService
    }
}
