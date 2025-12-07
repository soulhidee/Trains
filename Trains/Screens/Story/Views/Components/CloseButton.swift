import SwiftUI

struct CloseButton: View {
    
    // MARK: - Properties
    let action: () -> Void
    
    // MARK: - Body
    var body: some View {
        Button("", image: .close) {
            action()
        }
    }
}

// MARK: - Preview
#Preview {
    CloseButton {
        print("Жмяк")
    }
}
