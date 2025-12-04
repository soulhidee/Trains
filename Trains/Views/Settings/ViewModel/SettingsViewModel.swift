import Observation

@MainActor
@Observable
final class SettingsViewModel {
    
    // MARK: - Properties
    private let appearanceManager: AppearanceManager
    
    var isDarkMode: Bool {
            get { appearanceManager.isDarkMode }
            set { appearanceManager.isDarkMode = newValue }
        }
    
    var showUserAgreement: Bool = false
    
    // MARK: - Initialization
    init(appearanceManager: AppearanceManager = .shared) {
            self.appearanceManager = appearanceManager
        }
    
    // MARK: - Public Methods
    func openUserAgreement() {
        showUserAgreement = true
    }
    
    func closeUserAgreement() {
        showUserAgreement = false
    }

}
