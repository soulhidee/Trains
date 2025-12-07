import Foundation

// MARK: - DepartureTime
enum DepartureTime: String, CaseIterable {
    case morning
    case afternoon
    case evening
    case night
    
    // MARK: - Public Properties
    var title: String {
        switch self {
        case .morning: return Filter.DepartureTime.morning
        case .afternoon: return Filter.DepartureTime.afternoon
        case .evening: return Filter.DepartureTime.evening
        case .night: return Filter.DepartureTime.night
        }
    }
    
    var range: Range<Int> {
        switch self {
        case .morning: return 6..<12
        case .afternoon: return 12..<18
        case .evening: return 18..<24
        case .night: return 0..<6
        }
    }
}
