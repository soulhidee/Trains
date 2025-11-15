//
//  FindButton.swift
//  Trains
//
//  Created by Даниил on 15.11.2025.
//

import SwiftUI

struct FindButton: View {
    var body: some View {
        Button {
            
        } label: {
            Text("Найти")
                .padding(.vertical, 20)
                .padding(.horizontal, 47.5)
                .background(.ypBlue)
                .foregroundColor(.ypWhiteUniversal)
                .cornerRadius(16)
        }

        }
    }


#Preview {
    FindButton()
}
