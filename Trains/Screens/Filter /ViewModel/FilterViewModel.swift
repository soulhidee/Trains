import Combine
import SwiftUI

@MainActor
class FilterViewModel: ObservableObject {
    @Published var selectedTimes: Set<DepartureTime> = []
    @Published var showTransfers: Bool?
    @Published var hasAnySelection: Bool = false
    
    func toggleTimeSlot(_ time: DepartureTime) {
        if selectedTimes.contains(time) {
            selectedTimes.remove(time)
        } else {
            selectedTimes.insert(time)
        }
        updateSelection()
    }
    
    func toggleTransfers(_ isOn: Bool) {
        if showTransfers == isOn {
            showTransfers = nil
        } else {
            showTransfers = isOn
        }
        updateSelection()
    }
    
    func updateSelection() {
        hasAnySelection = !selectedTimes.isEmpty || showTransfers != nil
    }
    
    func applyFilters() {
        print("Applied filters: \(selectedTimes), transfers: \(String(describing: showTransfers))")
    }
}
