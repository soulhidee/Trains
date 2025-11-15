import Foundation

struct FilterSection: Identifiable {
    let id: UUID
    let title: String
    let items: [FilterItem]
}

struct FilterItem: Identifiable {
    let id: UUID
    let title: String
    let isSelected: Bool
    let selectionType: FilterRowView.SelectionType
    let action: () -> Void
}


enum Filter {
    static let departureTime = "Время отправления"
    static let showTransfers = "Показывать варианты с пересадками"
    static let yes = "Да"
    static let no = "Нет"
    
    enum DepartureTime {
        static let morning = "Утро 06:00 - 12:00"
        static let afternoon = "День 12:00 - 18:00"
        static let evening = "Вечер 18:00 - 00:00"
        static let night = "Ночь 00:00 - 06:00"
    }
}

enum DepartureTime: String, CaseIterable {
    case morning
    case afternoon
    case evening
    case night
    
    var title: String {
        switch self {
        case .morning: return Filter.DepartureTime.morning
        case .afternoon: return Filter.DepartureTime.afternoon
        case .evening: return Filter.DepartureTime.evening
        case .night: return Filter.DepartureTime.night
        }
    }
}

enum TransferOption: CaseIterable {
    case yes
    case no
    
    var title: String {
        switch self {
        case .yes: return Filter.yes
        case .no: return Filter.no
        }
    }
    
    var boolValue: Bool {
        self == .yes
    }
}
