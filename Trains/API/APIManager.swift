import SwiftKeychainWrapper

final class APIKeyManager: Sendable {
    // MARK: - Singleton
    static let shared = APIKeyManager()
    
    // MARK: - Private Properties
    private let keychainKey = "apiKey"
    
    // MARK: - Public Methods
    func getAPIKey() -> String {
        if let saved = KeychainWrapper.standard.string(forKey: keychainKey) {
            return saved
        }
        
        let key = Secrets.apiKey
        KeychainWrapper.standard.set(key, forKey: keychainKey)
        return key
    }
}
