
import SwiftUI

struct SwapButton: View {
    let action: () -> Void
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            action()
        }) {
            ZStack {
                Circle()
                    .fill(Color.ypWhiteUniversal)
                    .frame(width: 36, height: 36)
                Image(.change)
                    .foregroundStyle(.ypBlue)
            }
        }
        
    }
}

#Preview {
    SwapButton(action: {
        print("Tapped")
    })
}
