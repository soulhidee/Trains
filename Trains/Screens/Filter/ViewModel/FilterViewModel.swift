import Combine

@MainActor
class FilterViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var selectedTimes: Set<DepartureTime> = []
    @Published var showTransfers: Bool?
    
    // MARK: - Public Methods
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
    
    // MARK: - Computed Properties
    var hasFilters: Bool {
        !selectedTimes.isEmpty || showTransfers != nil
    }
}
