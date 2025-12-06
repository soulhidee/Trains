import Foundation
import Combine

@MainActor
final class AppState: ObservableObject {
    static let shared = AppState()
    
    @Published var isDataLoaded = false
    private var directoryService: DirectoryService?
    
    private init() {}
    
    func loadDataIfNeeded() async {
        guard directoryService == nil else { return } // Уже загружено
        
        print("🔄 Загружаем данные первый раз...")
        
        let service = DirectoryService(apikey: Secrets.apiKey)
        
        do {
            // Загружаем города - это закэширует весь JSON
            _ = try await service.fetchAllCities()
            print("✅ Данные загружены и закэшированы в памяти")
            
            directoryService = service
            isDataLoaded = true
        } catch {
            print("❌ Ошибка загрузки: \(error)")
        }
    }
    
    func getService() -> DirectoryService? {
        return directoryService
    }
}
