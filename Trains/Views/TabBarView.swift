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
        .safeAreaInset(edge: .bottom) {
            Rectangle()
                .frame(height: 1 / UIScreen.main.scale)
                .foregroundColor(.ypBlack.opacity(0.3))
                .padding(.bottom, 54)
        }
    }
}


#Preview {
    TabBarView()
}
