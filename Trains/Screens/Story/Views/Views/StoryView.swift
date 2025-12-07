import SwiftUI

// MARK: - StoryView
struct StoryView: View {
    
    // MARK: - Properties
    let story: Story
    
    // MARK: - Body
    var body: some View {
        story.backgroundImage
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: 40))
            .padding(.vertical, 51)
            .ignoresSafeArea()
            .overlay(
                // MARK: - Story Text Overlay
                VStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 16) {
                        storyTitle
                        storyDescription
                    }
                    .padding(.init(top: 0, leading: 16, bottom: 91, trailing: 16))
                }
            )
            .background(.ypBlackUniversal)
    
    }
    
    // MARK: - Private Views
    private var storyTitle: some View {
        Text(story.title)
            .font(.system(size: 34, weight: .bold))
            .lineLimit(2)
            .foregroundColor(.white)
    }
    
    private var storyDescription: some View {
        Text(story.description)
            .font(.system(size: 20, weight: .regular))
            .lineLimit(3)
            .foregroundColor(.white)
    }
}

// MARK: - Preview
#Preview {
    StoryView(story: Story.story1)
}
