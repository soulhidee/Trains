import SwiftUI

@main
struct TrainsApp: App {
    @State private var appearanceManager = AppearanceManager.shared
    @StateObject private var appState = AppState.shared
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .preferredColorScheme(
                    appearanceManager.isDarkMode ? .dark : .light
                )
                .task {
                    // Загружаем данные в фоне при старте приложения
                    await appState.loadDataIfNeeded()
                }
        }
    }
}
