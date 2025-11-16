import SwiftUI

struct SettingsView: View {
    var body: some View {
        ErrorView(image: Image(.errorServer), title: "Ошибка сервера")
    }
}

#Preview {
    SettingsView()
}
