import Foundation

final class UserDefaultsService {
    static let shared = UserDefaultsService()
    
    private let userDefaults = UserDefaults.standard
    
    private init() {}
    
    func saveSettings(_ settings: SettingsModel) {
        if let data = try? JSONEncoder().encode(settings) {
            userDefaults.set(data, forKey: "appSettings")
        }
    }
    
    func loadSettings() -> SettingsModel? {
        guard let data = userDefaults.data(forKey: "appSettings") else {
            return nil
        }
        return try? JSONDecoder().decode(SettingsModel.self, from: data)
    }
}
