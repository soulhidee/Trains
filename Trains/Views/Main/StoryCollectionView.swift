import SwiftUI

struct StoryCollectionView: View {
    @State private var viewedStories: Set<UUID> = []
    @State private var selectedStory: Story?
    @State private var showStoryContent = false
    
    private let stories = [Story.story1, Story.story2, Story.story3, Story.story4, Story.story5]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(stories) { story in
                    StoryItemView(
                        story: story,
                        isViewed: viewedStories.contains(story.id)
                    )
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedStory = story
                        showStoryContent = true
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 2)
        }
        .frame(height: 140)
        .fullScreenCover(isPresented: $showStoryContent) {
            if let startStory = selectedStory,
               let startIndex = stories.firstIndex(where: { $0.id == startStory.id }) {
                StoryContentView(
                    stories: stories,
                    startIndex: startIndex,
                    onStoryViewed: { viewedIndex in
                        viewedStories.insert(stories[viewedIndex].id)
                    }
                )
            }
        }
        .onChange(of: showStoryContent) { old, new in
            print("showStoryContent changed: \(new)")
        }
    }
}

#Preview {
    StoryCollectionView()
}
