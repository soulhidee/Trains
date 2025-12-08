import Foundation

struct SettingsModel: Codable, Sendable {
    var isDarkModeEnabled: Bool
    
    static let initialValue = SettingsModel(isDarkModeEnabled: false)
}
