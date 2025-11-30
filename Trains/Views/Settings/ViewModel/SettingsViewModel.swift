import Foundation

@Observable
class SettingsViewModel {
    
    // MARK: - Properties
    private(set) var settingsModel: SettingsModel
    var showUserAgreement: Bool = false
    
    
    // MARK: - Computed Property
    var isDarkMode: Bool {
        get {
            settingsModel.isDarkModeEnabled
        }
        set {
            settingsModel.isDarkModeEnabled = newValue
            saveSettings()
        }
    }
    
    // MARK: - Initialization
    init() {
        if let savedSettings = UserDefaultsService.shared.loadSettings() {
            self.settingsModel = savedSettings
        } else {
            self.settingsModel = .initialValue
        }
    }
    
    // MARK: - Public Methods
    func openUserAgreement() {
        showUserAgreement = true
    }
    
    func closeUserAgreement() {
        showUserAgreement = false
    }
    
    // MARK: - Private Methods
    private func saveSettings() {
        UserDefaultsService.shared.saveSettings(settingsModel)
    }
}
