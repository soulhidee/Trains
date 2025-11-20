import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            ErrorView(image: Image(.errorServer), title: "Ошибка сервера")
                .background(Color.ypWhite)
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.ypWhite)
        
    }
}

#Preview {
    SettingsView()
}
