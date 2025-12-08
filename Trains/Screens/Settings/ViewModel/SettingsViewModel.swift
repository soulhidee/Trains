import Combine

@MainActor
final class SettingsViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var isDarkMode: Bool {
        didSet {
            appearanceManager.isDarkMode = isDarkMode
        }
    }
    
    @Published var showUserAgreement: Bool = false
    
    // MARK: - Private Properties
    private let appearanceManager: AppearanceManager
    
    // MARK: - Initialization
    init(appearanceManager: AppearanceManager = .shared) {
        self.appearanceManager = appearanceManager
        self.isDarkMode = appearanceManager.isDarkMode
    }
    
    // MARK: - Public Methods
    func openUserAgreement() {
        showUserAgreement = true
    }
    
    func closeUserAgreement() {
        showUserAgreement = false
    }
}
