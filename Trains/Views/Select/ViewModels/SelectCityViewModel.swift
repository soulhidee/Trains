import Foundation
import Combine

@MainActor
final class SelectCityViewModel: ObservableObject {
    @Published var cities: [DirectoryCity] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText = ""
    
    private let appState = AppState.shared
    
    var filteredCities: [DirectoryCity] {
        if searchText.isEmpty {
            return cities
        }
        return cities.filter { $0.title.localizedStandardContains(searchText) }
    }
    
    func loadCities() async {
        isLoading = true
        errorMessage = nil
        
        // Загружаем данные если ещё не загружены
        await appState.loadDataIfNeeded()
        
        guard let service = appState.getService() else {
            errorMessage = "Не удалось загрузить данные"
            isLoading = false
            return
        }
        
        do {
            // Берём из кэша - мгновенно!
            let fetchedCities = try await service.fetchAllCities()
            cities = fetchedCities
            print("✅ Города загружены из кэша: \(cities.count)")
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
}
