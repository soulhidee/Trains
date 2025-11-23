import SwiftUI

struct SettingsView: View {
    // MARK: - Properties
    @EnvironmentObject var themeManager: ThemeManager
    @State private var showUserAgreement = false
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 24) {
            settingsList
            
            Spacer()
            
            SettingsInfoView()
            
            Spacer()
        }
        .background(Color.ypWhite)
        .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
        .fullScreenCover(isPresented: $showUserAgreement) {
            userAgreementFullScreen
        }
    }
    
    // MARK: - Subviews
    private var settingsList: some View {
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
                .buttonStyle(.plain)
        }
        .listStyle(.plain)
        .listRowSeparator(.hidden)
        .environment(\.defaultMinListRowHeight, 60)
        .scrollDisabled(true)
        .scrollContentBackground(.hidden)
        .background(Color.ypWhite)
    }
    
    private var userAgreementFullScreen: some View {
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

// MARK: - Preview
#Preview {
    SettingsView()
        .environmentObject(ThemeManager())
}
