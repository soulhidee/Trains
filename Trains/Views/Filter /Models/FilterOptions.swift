import Foundation

struct FilterOptions {
    var selectedTimes: Set<DepartureTime> = []
    var showTransfers: Bool?
    
    var hasAnySelection: Bool {
        return !selectedTimes.isEmpty || showTransfers != nil
    }
}
