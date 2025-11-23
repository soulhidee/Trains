import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    var body: some View {
        VStack(spacing: 24) {
            List {
                SettingsRowView(
                    title: "Темная тема",
                    showToggle: true,
                    isOn: $themeManager.isDarkMode
                )
                
                SettingsRowView(
                    title: "Пользавтальское соглашение",
                    showChevron: true) {
                        print("Нажал")
                    }
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .listRowSeparator(.hidden)
            .environment(\.defaultMinListRowHeight, 60)
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)
            .background(Color.ypWhite)
            
            Spacer()
            
            SettingsInfoView()
            
            Spacer()
        }
        .background(Color.ypWhite)
        .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
    }

}

#Preview {
    SettingsView()
        .environmentObject(ThemeManager())
}
