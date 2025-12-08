import SwiftUI

struct FilterHeaderView: View {
    // MARK: - Properties
    let title: String
    
    // MARK: - Body
    var body: some View {
        Text(title)
            .font(.system(size: 24, weight: .bold))
            .foregroundStyle(.ypBlack)
    }
}

// MARK: - Preview
#Preview {
    FilterHeaderView(title: "Header")
}
