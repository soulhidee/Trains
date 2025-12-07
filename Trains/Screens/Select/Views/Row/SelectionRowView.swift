import SwiftUI

struct SelectionRowView: View {
    // MARK: - Properties
    let title: String
    
    // MARK: - Body
    var body: some View {
        HStack {
            rowTitle
            Spacer()
            rowIcon
        }
        .background(Color.ypWhite)
    }
    
    // MARK: - Private Views
    private var rowTitle: some View {
        Text(title)
            .font(.system(size: 17, weight: .regular))
            .foregroundStyle(.ypBlack)
    }
    
    private var rowIcon: some View {
        Image(.arrow)
            .foregroundStyle(.ypBlack)
    }
}

// MARK: - Preview
#Preview {
    SelectionRowView(title: "Москва")
}
