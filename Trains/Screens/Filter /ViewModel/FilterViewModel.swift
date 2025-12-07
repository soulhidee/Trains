import Combine

@MainActor
class FilterViewModel: ObservableObject {
    @Published var selectedTimes: Set<DepartureTime> = []
    @Published var showTransfers: Bool?
    
    func toggleTimeSlot(_ time: DepartureTime) {
        if selectedTimes.contains(time) {
            selectedTimes.remove(time)
        } else {
            selectedTimes.insert(time)
        }
    }
    
    func toggleTransfers(_ isOn: Bool) {
        if showTransfers == isOn {
            showTransfers = nil
        } else {
            showTransfers = isOn
        }
    }
    
    var hasFilters: Bool {
        !selectedTimes.isEmpty || showTransfers != nil
    }
}
