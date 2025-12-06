import Foundation
import Combine

@MainActor
final class SelectStationViewModel: ObservableObject {
    @Published var stations: [DirectoryStation] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText = ""
    
    private let cityName: String
    private let appState = AppState.shared
    
    init(cityName: String) {
        self.cityName = cityName
    }
    
    var filteredStations: [DirectoryStation] {
        if searchText.isEmpty {
            return stations
        }
        return stations.filter { $0.title.localizedStandardContains(searchText) }
    }
    
    func loadStations() async {
        isLoading = true
        errorMessage = nil
        
        // Данные уже должны быть загружены после выбора города
        if appState.getService() == nil {
            // На всякий случай загружаем
            await appState.loadDataIfNeeded()
        }
        
        guard let service = appState.getService() else {
            errorMessage = "Не удалось загрузить данные"
            isLoading = false
            return
        }
        
        do {
            // Берём из кэша - быстро!
            let fetchedStations = try await service.fetchStations(inCityTitle: cityName)
            stations = fetchedStations
            print("✅ Станции для \(cityName) загружены из кэша: \(stations.count)")
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
}
