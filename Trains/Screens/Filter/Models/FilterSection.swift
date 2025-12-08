import Foundation

// MARK: - FilterSection
struct FilterSection: Identifiable, Sendable {
    let id: String
    let title: String
    let items: [FilterItem]
    let itemTypes: [FilterItemType]
}
