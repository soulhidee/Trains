import Foundation
import Combine

@MainActor
final class StoryViewModel: ObservableObject {
    @Published var currentStoryIndex: Int
    @Published var progress: CGFloat = 0
    @Published var isTimerRunning = false
    
    let stories: [Story]
    private let timerManager: StoryTimerManager
    private let navigationManager: StoryNavigationManager
    private var cancellables = Set<AnyCancellable>()
    
    var currentStory: Story {
        navigationManager.currentStory
    }
    
    var storiesCount: Int {
        stories.count
    }
    
    var combinedProgress: CGFloat {
        let storyProgress = navigationManager.progressForCurrentStory()
        let currentStoryProgress = progress - storyProgress
        return storyProgress + currentStoryProgress
    }
    
    init(stories: [Story] = [.story1, .story2, .story3], startIndex: Int = 0) {
        self.stories = stories
        self.currentStoryIndex = startIndex
        
        let config = StoryTimerManager.Configuration(storiesCount: stories.count)
        self.timerManager = StoryTimerManager(configuration: config)
        self.navigationManager = StoryNavigationManager(stories: stories, startIndex: startIndex)
        
        setupBindings()
    }
    
    private func setupBindings() {
        timerManager.$progress
            .assign(to: &$progress)
        
        navigationManager.$currentStoryIndex
            .assign(to: &$currentStoryIndex)
    }
    
    func onAppear() {
        let initialProgress = navigationManager.progressForCurrentStory()
        timerManager.setProgress(initialProgress)
        timerManager.start()
    }
    
    func onDisappear() {
        timerManager.pause()
    }
    
    func handleTap() {
        moveToNextStory()
    }
    
    func handleSwipeLeft() {
        moveToNextStory()
    }
    
    func handleSwipeRight() {
        moveToPreviousStory()
    }
    
    func shouldDismiss() -> Bool {
        return progress >= 1.0
    }
    
    func handleProgressChange(_ newValue: CGFloat) {
        let newStoryIndex = Int(newValue * CGFloat(navigationManager.storiesCount))
        
        if newStoryIndex != navigationManager.currentStoryIndex
            && newStoryIndex < navigationManager.storiesCount {
            navigationManager.setStoryIndex(from: newValue)
        }
    }
    
    private func moveToNextStory() {
        navigationManager.nextStory()
        updateTimerForCurrentStory()
    }
    
    private func moveToPreviousStory() {
        navigationManager.previousStory()
        updateTimerForCurrentStory()
    }
    
    private func updateTimerForCurrentStory() {
        let newProgress = navigationManager.progressForCurrentStory()
        timerManager.setProgress(newProgress)
        timerManager.reset()
    }
}
