//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by Даниил on 16.10.2025.
//

import SwiftUI

@main
struct TrainsApp: App {
    @State private var appearanceManager = AppearanceManager.shared
    var body: some Scene {
        WindowGroup {
            SplashView()
                .preferredColorScheme(
                    appearanceManager.isDarkMode ? .dark : .light
                )
        }
    }
}
