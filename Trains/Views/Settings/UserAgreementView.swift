//
//  UserAgreementView.swift
//  Trains
//
//  Created by Даниил on 23.11.2025.
//

import SwiftUI


struct UserAgreementView: View {
    var body: some View {
        WebView(url: URL(string: "https://yandex.ru/legal/practicum_offer/ru/")!)
            .edgesIgnoringSafeArea(.bottom)
    }
}



#Preview {
    NavigationStack {
        UserAgreementView()
            .navigationTitle("Пользовательское соглашение")
            .navigationBarTitleDisplayMode(.inline)
    }
}
