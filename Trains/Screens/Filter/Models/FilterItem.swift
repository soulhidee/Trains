import Foundation

// MARK: - FilterItem
struct FilterItem: Identifiable, Sendable {
    let id: String
    let title: String
    let isSelected: Bool
    let selectionType: FilterRowView.SelectionType
}
