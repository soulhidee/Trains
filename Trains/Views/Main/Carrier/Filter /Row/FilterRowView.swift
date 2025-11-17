//
//  FilterRowView.swift
//  Trains
//
//  Created by Даниил on 15.11.2025.
//

import SwiftUI

struct FilterRowView: View {
    let title: String
    let isSelected: Bool
    let selectionType: SelectionType
    
    enum SelectionType {
        case checkbox
        case radio
    }
    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(.ypBlack)
                .font(.system(size: 17, weight: .regular))
            
            Spacer()
            
            Image(systemName: iconName)
                .font(.system(size: 24))
        }
        .background(Color.ypWhite)
    }
    
    private var iconName: String {
        switch selectionType {
        case .checkbox:
            isSelected ? "checkmark.square.fill" : "square"
        case .radio:
            isSelected ? "record.circle" : "circle"
        }
    }
}

#Preview {
    VStack {
        FilterRowView(title: "Утро 06:00 - 12:00", isSelected: true, selectionType: .checkbox)
        FilterRowView(title: "Да", isSelected: false, selectionType: .radio)
    }
    .padding()
}
