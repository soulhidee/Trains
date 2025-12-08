import SwiftUI
import Combine

@MainActor
final class AppearanceManager: ObservableObject {
    // MARK: - Singleton
    static let shared = AppearanceManager()
    
    // MARK: - Published Properties
    @Published var isDarkMode: Bool = false {
        didSet { save() }
    }
    
    // MARK: - Init
    private init() {
        load()
    }
    
    // MARK: - Load & Save
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
