import Foundation

// MARK: - Settings Model
struct SettingsModel: Codable {
    var isDarkModeEnabled: Bool
    
    static let initialValue = SettingsModel(isDarkModeEnabled: false)
}
