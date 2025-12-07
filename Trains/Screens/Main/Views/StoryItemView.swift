import SwiftUI

struct StoryItemView: View {
    // MARK: - Properties
    let story: Story
    let isViewed: Bool
    
    // MARK: - Body
    var body: some View {
        ZStack {
            backgroundImage
            storyTitleOverlay
        }
        .frame(width: 92, height: 140)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isViewed ? Color.clear : Color.ypBlue, lineWidth: 4)
        )
    }
    
    // MARK: - Private Views
    private var backgroundImage: some View {
        story.backgroundImage
            .resizable()
            .scaledToFill()
            .frame(width: 92, height: 140)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .opacity(isViewed ? 0.5 : 1.0)
    }
    
    private var storyTitleOverlay: some View {
        VStack {
            Spacer()
            Text(story.title)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.ypWhiteUniversal)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 8)
                .padding(.bottom, 12)
                .opacity(isViewed ? 0.5 : 1.0)
        }
        .frame(width: 92, height: 140)
    }
}

// MARK: - Preview
#Preview {
    HStack(spacing: 12) {
        StoryItemView(story: Story.story4, isViewed: true)
        StoryItemView(story: Story.story5, isViewed: false)
    }
}
