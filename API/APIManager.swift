import SwiftKeychainWrapper

class APIKeyManager {
    static let shared = APIKeyManager()
    private let keychainKey = "apiKey"
    
    func getAPIKey() -> String {
        // Проверяем keychain
        if let saved = KeychainWrapper.standard.string(forKey: keychainKey) {
            return saved
        }
        
        // Сохраняем из Secrets в keychain
        let key = Secrets.apiKey
        KeychainWrapper.standard.set(key, forKey: keychainKey)
        return key
    }
}
