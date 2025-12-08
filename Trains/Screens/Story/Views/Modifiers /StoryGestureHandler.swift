import SwiftUI

struct StoryGestureHandler: ViewModifier {
    
    // MARK: - Callbacks
    let onTap: () -> Void
    let onSwipeLeft: () -> Void
    let onSwipeRight: () -> Void
    
    // MARK: - State
    @State private var dragOffset: CGFloat = 0
    
    // MARK: - Constants
    private let swipeThreshold: CGFloat = 50
    
    // MARK: - Body
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                onTap()
            }
            .gesture(
                DragGesture(minimumDistance: 20)
                    .onChanged { value in
                        dragOffset = value.translation.width
                    }
                    .onEnded { value in
                        handleSwipe(translation: value.translation.width)
                        dragOffset = 0
                    }
            )
    }
    
    // MARK: - Private Methods
    private func handleSwipe(translation: CGFloat) {
        if translation < -swipeThreshold {
            onSwipeLeft()
        } else if translation > swipeThreshold {
            onSwipeRight()
        }
    }
}

// MARK: - View Extension
extension View {
    func storyGestures(
        onTap: @escaping () -> Void,
        onSwipeLeft: @escaping () -> Void,
        onSwipeRight: @escaping () -> Void
    ) -> some View {
        modifier(StoryGestureHandler(
            onTap: onTap,
            onSwipeLeft: onSwipeLeft,
            onSwipeRight: onSwipeRight
        ))
    }
}
