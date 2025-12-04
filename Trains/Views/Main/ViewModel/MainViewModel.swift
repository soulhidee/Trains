import Combine

@MainActor
final class MainViewModel: ObservableObject {
    @Published var fromCity = ""
    @Published var fromStation = ""
    @Published var toCity = ""
    @Published var toStation = ""
    @Published var showCarrierList = false
    
    var isReadyToSearch: Bool {
        !fromCity.isEmpty && !toCity.isEmpty
    }
    
    func openCarrierList() {
        showCarrierList = true
    }
    
    func closeCarrierList() {
        showCarrierList = false
    }
    
    func resetLocations() {
        fromCity = ""
        fromStation = ""
        toCity = ""
        toStation = ""
    }
    
    func swapLocations() {
        let tempCity = fromCity
        let tempStation = fromStation
        
        fromCity = toCity
        fromStation = toStation
        
        toCity = tempCity
        toStation = tempStation
    }
}
