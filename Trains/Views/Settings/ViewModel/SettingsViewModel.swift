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
            
        }
    }
}
