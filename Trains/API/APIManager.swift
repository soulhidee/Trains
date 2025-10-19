import SwiftKeychainWrapper

class APIKeyManager {
    static let shared = APIKeyManager()
    private let keychainKey = "apiKey"
    
    func getAPIKey() -> String {
        if let saved = KeychainWrapper.standard.string(forKey: keychainKey) {
            return saved
        }
        
        let key = Secrets.apiKey
        KeychainWrapper.standard.set(key, forKey: keychainKey)
        return key
    }
}
