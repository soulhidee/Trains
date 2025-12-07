import SwiftUI

struct SwapButton: View {
    // MARK: - Properties
    let action: () -> Void
    @State private var isPressed = false
    
    // MARK: - Body
    var body: some View {
        Button(action: {
            action()
        }) {
            buttonContent
        }
    }
    
    // MARK: - Private Views
    private var buttonContent: some View {
        ZStack {
            Circle()
                .fill(Color.ypWhiteUniversal)
                .frame(width: 36, height: 36)
            Image(.change)
                .foregroundStyle(.ypBlue)
        }
    }
}

// MARK: - Preview
#Preview {
    SwapButton(action: {
        print("Tapped")
    })
}
