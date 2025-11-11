//
//  TabBarView.swift
//  Trains
//
//  Created by Даниил on 11.11.2025.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            MainView()
                .tabItem {
                    Image(.schedule)
                        .renderingMode(.template)
                }
                .tag(0)
            SettingsView()
                .tabItem {
                    Image(.settings)
                        .renderingMode(.template)
                }
                .tag(1)
        }
        .tint(.ypBlack)
    }
}

#Preview {
    TabBarView()
}
