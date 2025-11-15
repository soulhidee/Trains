import SwiftUI

struct FilterHeaderView: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.system(size: 24, weight: .bold))
            .foregroundStyle(.ypBlack)
    }
}

#Preview {
    FilterHeaderView(title: "Header")
}
