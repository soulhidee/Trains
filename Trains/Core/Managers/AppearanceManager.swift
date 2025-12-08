import SwiftUI
import Combine

@MainActor
final class AppearanceManager: ObservableObject {
    static let shared = AppearanceManager()
    
    @Published var isDarkMode: Bool = false {
        didSet {
            save()
        }
    }
    
    private init() {
        load()
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
