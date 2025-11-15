//
//  CarrierListView.swift
//  Trains
//
//  Created by Даниил on 15.11.2025.
//

import SwiftUI

struct CarrierListView: View {
    let fromCity: String
    let toCity: String
    let fromStation: String
    let toStation: String
    
    @Environment(\.dismiss) private var dismiss
    
    private var routeTitle: String {
        "\(fromCity)\(fromStation.isEmpty ? "" : " (\(fromStation))") → \(toCity)\(toStation.isEmpty ? "" : " (\(toStation))")"
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 16) {
                Text(routeTitle)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.ypBlack)
                    .padding()
                
                List {
                    ForEach(0..<3) { _ in
                            Text("Перевозчик")
                            .padding()
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(.plain)

            }
            PrimaryButton(title: "Уточнить Вермя", action: {
                
            })
            .padding()
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.ypBlack)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CarrierListView(
            fromCity: "Москва",
            toCity: "Санкт Петербург",
            fromStation: "Ярославский вокзал",
            toStation: "Балтийский вокзал"
        )
    }
}
