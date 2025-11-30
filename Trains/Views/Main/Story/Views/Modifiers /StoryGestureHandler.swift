import SwiftUI

struct StoryGestureHandler: ViewModifier {
    let onTap: () -> Void
    let onSwipeLeft: () -> Void
    let onSwipeRight: () -> Void
    
    @State private var dragOffset: CGFloat = 0
    private let swipeThreshold: CGFloat = 50
    
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
                        let horizontalMovement = value.translation.width
                        
                        if horizontalMovement < -swipeThreshold {
                            onSwipeLeft()
                        } else if horizontalMovement > swipeThreshold {
                            onSwipeRight()
                        }
                        
                        dragOffset = 0
                    }
            )
    }
}

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
