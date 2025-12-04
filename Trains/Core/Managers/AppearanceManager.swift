import SwiftUI

@Observable
final class AppearanceManager: Sendable {
    static let shared = AppearanceManager()
    
    private init() {
        load()
    }
    
    var isDarkMode: Bool = false {
        didSet {
            save()
        }
    }
    
    private func load() {
        if let saved = UserDefaultsService.shared.loadSettings()?.isDarkModeEnabled {
            isDarkMode = saved
        } else {
            isDarkMode = UITraitCollection.current.userInterfaceStyle == .dark
        }
    }
    
    private func save() {
        UserDefaultsService.shared.saveSettings(SettingsModel(isDarkModeEnabled: isDarkMode))
    }
}
