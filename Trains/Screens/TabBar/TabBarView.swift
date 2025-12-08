import SwiftUI

struct TabBarView: View {
    // MARK: - Properties
    @State private var selectedTab = 0
    
    // MARK: - Body
    var body: some View {
        TabView(selection: $selectedTab) {

            // MARK: - Main Tab
            MainView()
                .tabItem {
                    Image(.schedule)
                        .renderingMode(.template)
                }
                .tag(0)
            
            // MARK: - Settings Tab
            SettingsView()
                .tabItem {
                    Image(.settings)
                        .renderingMode(.template)
                }
                .tag(1)
        }
        .tint(.ypBlack)
        .safeAreaInset(edge: .bottom) {
            Rectangle()
                .frame(height: 1 / UIScreen.main.scale)
                .foregroundColor(.ypBlack.opacity(0.3))
                .padding(.bottom, 54)
        }
    }
}

// MARK: - Preview
#Preview {
    TabBarView()
}
