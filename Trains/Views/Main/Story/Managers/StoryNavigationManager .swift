import Foundation
import Combine

final class StoryNavigationManager: ObservableObject {
    @Published private(set) var currentStoryIndex: Int = 0
    
    private let stories: [Story]
    
    var currentStory: Story {
        stories[currentStoryIndex]
    }
    
    var storiesCount: Int {
        stories.count
    }
    
    init(stories: [Story]) {
        self.stories = stories
    }
    
    func nextStory() {
        if currentStoryIndex + 1 < stories.count {
            currentStoryIndex += 1
        } else {
            currentStoryIndex = 0
        }
    }
    
    func previousStory() {
        if currentStoryIndex > 0 {
            currentStoryIndex -= 1
        } else {
            currentStoryIndex = stories.count - 1
        }
    }
    
    func progressForCurrentStory() -> CGFloat {
        CGFloat(currentStoryIndex) / CGFloat(stories.count)
    }
    
    func setStoryIndex(from progress: CGFloat) {
        let index = Int(progress * CGFloat(stories.count))
        currentStoryIndex = min(max(index, 0), stories.count - 1)
    }
}
