import SwiftUI

struct StoryCollectionView: View {
    // MARK: - State
    @State private var viewedStories: Set<UUID> = []
    @State private var selectedStory: Story?
    @State private var showStoryContent = false
    
    // MARK: - Data
    private let stories = [Story.story1, Story.story2, Story.story3, Story.story4, Story.story5]
    
    // MARK: - Body
    var body: some View {
        storyScrollView
            .fullScreenCover(isPresented: $showStoryContent) {
                storyContentView
            }
            .onChange(of: showStoryContent) { _, new in
                print("showStoryContent changed: \(new)")
            }
    }
    
    // MARK: - Subviews
    private var storyScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(stories) { story in
                    storyItem(for: story)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 2)
        }
        .frame(height: 140)
    }
    
    private func storyItem(for story: Story) -> some View {
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
    
    private var storyContentView: some View {
        if let startStory = selectedStory,
           let startIndex = stories.firstIndex(where: { $0.id == startStory.id }) {
            return AnyView(
                StoryContentView(
                    stories: stories,
                    startIndex: startIndex,
                    onStoryViewed: { viewedIndex in
                        viewedStories.insert(stories[viewedIndex].id)
                    }
                )
            )
        } else {
            return AnyView(EmptyView())
        }
    }
}

// MARK: - Preview
#Preview {
    StoryCollectionView()
}
