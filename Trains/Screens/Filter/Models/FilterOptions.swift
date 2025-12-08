import Foundation

//MARK: - FilterOptions
struct FilterOptions: Sendable {
    var selectedTimes: Set<DepartureTime> = []
    var showTransfers: Bool?
    
    var hasAnySelection: Bool {
        return !selectedTimes.isEmpty || showTransfers != nil
    }
}
