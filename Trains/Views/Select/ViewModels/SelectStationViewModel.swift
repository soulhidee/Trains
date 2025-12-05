import Foundation
import Combine

@MainActor
final class SelectStationViewModel: ObservableObject {
    @Published var stations: [DirectoryStation] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText = ""
    
    private let cityName: String
    
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
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        
        do {
            let fetchedStations = try await APIClient.shared.fetchStations(inCityTitle: cityName, apikey: Secrets.apiKey)
            await MainActor.run {
                self.stations = fetchedStations
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}
