import Foundation

// MARK: - TransferOption
enum TransferOption: CaseIterable, Sendable {
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
