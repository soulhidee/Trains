import Combine
import Foundation

@MainActor
final class MainViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var fromCity = ""
    @Published var fromStation = ""
    @Published var fromCode = ""
    @Published var toCity = ""
    @Published var toStation = ""
    @Published var toCode = ""
    @Published var showCarrierList = false
    @Published var errorMessage: String?
    
    // MARK: - Computed Properties
    var isReadyToSearch: Bool {
        !fromCity.isEmpty && !toCity.isEmpty &&
        !fromStation.isEmpty && !toStation.isEmpty &&
        !fromCode.isEmpty && !toCode.isEmpty
    }
    
    // MARK: - Station Selection
    func setFromStation(_ station: DirectoryStation) {
        fromStation = station.title
        fromCode = station.yandexCode ?? ""
        print("✅ Установлена fromStation: '\(station.title)', код: '\(fromCode)'")
    }
    
    func setToStation(_ station: DirectoryStation) {
        toStation = station.title
        toCode = station.yandexCode ?? ""
        print("✅ Установлена toStation: '\(station.title)', код: '\(toCode)'")
    }
    
    // MARK: - Carrier List
    func openCarrierList() {
        guard isReadyToSearch else {
            errorMessage = "Заполните все поля"
            return
        }
        
        print("✅ Открываем список рейсов:")
        print("  from: '\(fromCity)' (\(fromStation)) - код: '\(fromCode)'")
        print("  to: '\(toCity)' (\(toStation)) - код: '\(toCode)'")
        
        showCarrierList = true
    }
    
    func closeCarrierList() {
        showCarrierList = false
    }
    
    // MARK: - Location Management
    func resetLocations() {
        fromCity = ""
        fromStation = ""
        fromCode = ""
        toCity = ""
        toStation = ""
        toCode = ""
    }
    
    func swapLocations() {
        swap(&fromCity, &toCity)
        swap(&fromStation, &toStation)
        swap(&fromCode, &toCode)
    }
}
