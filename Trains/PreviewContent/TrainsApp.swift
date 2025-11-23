//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by Даниил on 16.10.2025.
//

import SwiftUI

@main
struct TrainsApp: App {
    @StateObject private var themeManager = ThemeManager()
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(themeManager)
                .preferredColorScheme(themeManager.colorScheme)
        }
    }
}
