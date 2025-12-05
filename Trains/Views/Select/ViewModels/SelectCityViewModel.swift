import Foundation
import Combine

@MainActor
final class SelectCityViewModel: ObservableObject {
    @Published var cities: [DirectoryCity] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText = ""
    
    var filteredCities: [DirectoryCity] {
        if searchText.isEmpty {
            return cities
        }
        return cities.filter { $0.title.localizedStandardContains(searchText) }
    }
    
    func loadCities() async {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        
        do {
            let fetchedCities = try await APIClient.shared.fetchAllCities(apikey: Secrets.apiKey)
            await MainActor.run {
                self.cities = fetchedCities
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
