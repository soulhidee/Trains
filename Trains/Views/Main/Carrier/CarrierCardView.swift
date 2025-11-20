//
//  CarrierCardView.swift
//  Trains
//
//  Created by Даниил on 16.11.2025.
//

import SwiftUI

struct CarrierCardView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("Тут будет информация о перевозчике")
                .navigationTitle("Информация о перевозчике")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
            
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundStyle(.ypBlack)
                        }
                    }
                }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.ypWhite)
    }
    
}

#Preview {
    NavigationStack {
        CarrierCardView()
    }
}
