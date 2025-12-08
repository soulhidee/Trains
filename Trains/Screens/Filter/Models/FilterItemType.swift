import Foundation

// MARK: - FilterItemType
enum FilterItemType: Sendable {
    case timeSlot(DepartureTime)
    case transfer(TransferOption)
}
