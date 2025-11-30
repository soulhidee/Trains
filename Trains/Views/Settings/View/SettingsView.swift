import SwiftUI

struct SettingsView: View {
    
    // MARK: - Properties
    @State private var viewModel = SettingsViewModel()
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 24) {
            settingsList
            
            Spacer()
            
            SettingsInfoView()
            
            Spacer()
        }
        .padding(.top, 24)
        .background(Color.ypWhite)
        .fullScreenCover(isPresented: $viewModel.showUserAgreement) {
            userAgreementFullScreen
        }
    }
    
    // MARK: - Subviews
    private var settingsList: some View {
        List {
            SettingsRowView(
                title: "Темная тема",
                showToggle: true,
                isOn: $viewModel.isDarkMode
            )
            
            SettingsRowView(
                title: "Пользовательское соглашение",
                showChevron: true
            ) {
                viewModel.openUserAgreement()
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
                            viewModel.closeUserAgreement()
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
}
