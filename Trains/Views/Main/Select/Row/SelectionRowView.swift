import SwiftUI

struct SelectionRowView: View {
    let title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 17, weight: .regular))
                .foregroundStyle(.ypBlack)
            Spacer()
            Image(.arrow)
                .foregroundStyle(.ypBlack)
        }
        .background(Color.ypWhite)
    }
}

#Preview {
    SelectionRowView(title: "Москва")
}
