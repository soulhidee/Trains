//
//  ErrorView.swift
//  Trains
//
//  Created by Даниил on 16.11.2025.
//

import SwiftUI

struct ErrorView: View {
    let image: Image
    let title: String
    
    var body: some View {
        VStack(spacing: 16) {
            image
                .resizable()
                .frame(width: 223, height: 223)
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.ypBlack)
        }
    }
}

#Preview {
    ErrorView(image: Image(.errorServer), title: "Ошибка сервера")
}
