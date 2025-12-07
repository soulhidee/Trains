// SwapButton.swift
import SwiftUI

struct SwapButton: View {
    // MARK: - Properties
    let action: () -> Void
    @State private var isPressed = false
    @State private var rotationAngle: Double = 0
    
    // MARK: - Body
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.6)) {
                rotationAngle += 180
            }
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
        .rotationEffect(.degrees(rotationAngle))
    }
}

// MARK: - Preview
#Preview {
    SwapButton(action: {
        print("Tapped")
    })
}
