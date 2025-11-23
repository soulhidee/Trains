import SwiftUI

struct SettingsView: View {
    @State private var isDarkMode = false
    var body: some View {
        VStack(spacing: 24) {
            List {
                SettingsRowView(
                    title: "Темная тема",
                    showToggle: true,
                    isOn: $isDarkMode
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
            .background(Color.ypWhite)
            
            Spacer()
            
            SettingsInfoView()
            
            Spacer()
        }
    }

}

#Preview {
    TabBarView()
}
