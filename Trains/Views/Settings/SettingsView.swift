import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var themeManager: ThemeManager
    @State private var showUserAgreement = false
    
    var body: some View {
        VStack(spacing: 24) {
            List {
                SettingsRowView(
                    title: "Темная тема",
                    showToggle: true,
                    isOn: $themeManager.isDarkMode
                )
                
                SettingsRowView(
                    title: "Пользовательское соглашение",
                    showChevron: true) {
                        showUserAgreement = true
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
        .fullScreenCover(isPresented: $showUserAgreement) {
            NavigationStack {
                UserAgreementView()
                    .navigationTitle("Пользовательское соглашение")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                showUserAgreement = false
                            }) {
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.ypBlack)
                                    .font(.system(size: 17, weight: .semibold))
                            }
                        }
                    }
            }
        }
    }

}

#Preview {
    SettingsView()
        .environmentObject(ThemeManager())
}
