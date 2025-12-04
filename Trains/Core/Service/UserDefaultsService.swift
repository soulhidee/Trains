import Foundation

final class UserDefaultsService: Sendable {
    static let shared = UserDefaultsService()
    
    private init() {}
    
    func saveSettings(_ settings: SettingsModel) {
        if let data = try? JSONEncoder().encode(settings) {
            UserDefaults.standard.set(data, forKey: "appSettings")
        }
    }
    
    func loadSettings() -> SettingsModel? {
        guard let data = UserDefaults.standard.data(forKey: "appSettings") else {
            return nil
        }
        return try? JSONDecoder().decode(SettingsModel.self, from: data)
    }
}
