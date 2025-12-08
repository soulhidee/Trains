import SwiftUI

struct UserAgreementView: View {
    // MARK: - Body
    var body: some View {
        // MARK: - Web Content
        if let url = URL(string: "https://yandex.ru/legal/practicum_offer/ru/") {
            WebView(url: url)
                .edgesIgnoringSafeArea(.bottom)
        } else {
            // MARK: - Error State
            Text("Ошибка загрузки документа")
                .foregroundColor(.ypRed)
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        UserAgreementView()
            .navigationTitle("Пользовательское соглашение")
            .navigationBarTitleDisplayMode(.inline)
    }
}
