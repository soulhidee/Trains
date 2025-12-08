import SwiftUI

struct FilterRowView: View {
    // MARK: - Properties
    let title: String
    let isSelected: Bool
    let selectionType: SelectionType
    
    // MARK: - Private Computed Properties
    private var iconName: String {
        switch selectionType {
        case .checkbox:
            isSelected ? "checkmark.square.fill" : "square"
        case .radio:
            isSelected ? "record.circle" : "circle"
        }
    }
    
    // MARK: - Selection Type
    enum SelectionType {
        case checkbox
        case radio
    }
    
    // MARK: - Body
    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(.ypBlack)
                .font(.system(size: 17, weight: .regular))
            
            Spacer()
            
            Image(systemName: iconName)
                .font(.system(size: 24))
                .foregroundStyle(.ypBlue)
        }
        .background(Color.ypWhite)
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: 16) {
        FilterRowView(title: "Утро 06:00 - 12:00", isSelected: true, selectionType: .checkbox)
        FilterRowView(title: "Да", isSelected: false, selectionType: .radio)
    }
    .padding()
}
