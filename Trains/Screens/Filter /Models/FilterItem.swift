import Foundation

//MARK: - FilterItem
struct FilterItem: Identifiable {
    let id: String
    let title: String
    let isSelected: Bool
    let selectionType: FilterRowView.SelectionType
    let action: () -> Void
}
