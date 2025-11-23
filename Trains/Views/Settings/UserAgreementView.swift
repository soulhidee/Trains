//
//  UserAgreementView.swift
//  Trains
//
//  Created by Даниил on 23.11.2025.
//

import SwiftUI


struct UserAgreementView: View {
    var body: some View {
        if let url = URL(string: "https://yandex.ru/legal/practicum_offer/ru/") {
            WebView(url: url)
                .edgesIgnoringSafeArea(.bottom)
        } else {
            Text("Ошибка загрузки документа")
                .foregroundColor(.ypRed)
        }
    }
}



#Preview {
    NavigationStack {
        UserAgreementView()
            .navigationTitle("Пользовательское соглашение")
            .navigationBarTitleDisplayMode(.inline)
    }
}
