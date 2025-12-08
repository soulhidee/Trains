import Foundation
import Combine

final class StoryNavigationManager: ObservableObject {
    // MARK: - Published Properties
    @Published private(set) var currentStoryIndex: Int
    
    // MARK: - Private Properties
    private let stories: [Story]
    
    // MARK: - Computed Properties
    var currentStory: Story {
        stories[currentStoryIndex]
    }
    
    var storiesCount: Int {
        stories.count
    }
    
    // MARK: - Initialization
    init(stories: [Story], startIndex: Int = 0) {
        self.stories = stories
        self.currentStoryIndex = min(max(startIndex, 0), stories.count - 1)
    }
    
    // MARK: - Navigation Methods
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
    
    // MARK: - Progress Methods
    func progressForCurrentStory() -> CGFloat {
        CGFloat(currentStoryIndex) / CGFloat(stories.count)
    }
    
    func setStoryIndex(from progress: CGFloat) {
        let index = Int(progress * CGFloat(stories.count))
        currentStoryIndex = min(max(index, 0), stories.count - 1)
    }
}
