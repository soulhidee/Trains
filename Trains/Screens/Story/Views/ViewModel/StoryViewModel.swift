import Foundation
import Combine

// MARK: - StoryViewModel
@MainActor
final class StoryViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var currentStoryIndex: Int
    @Published var progress: CGFloat = 0
    @Published var isTimerRunning = false
    
    // MARK: - Private Properties
    let stories: [Story]
    private let timerManager: StoryTimerManager
    private let navigationManager: StoryNavigationManager
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Computed Properties
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
    
    // MARK: - Initialization
    init(stories: [Story] = [.story1, .story2, .story3], startIndex: Int = 0) {
        self.stories = stories
        self.currentStoryIndex = startIndex
        
        let config = StoryTimerManager.Configuration(storiesCount: stories.count)
        self.timerManager = StoryTimerManager(configuration: config)
        self.navigationManager = StoryNavigationManager(stories: stories, startIndex: startIndex)
        
        setupBindings()
    }
    
    // MARK: - Bindings
    private func setupBindings() {
        timerManager.$progress
            .assign(to: &$progress)
        
        navigationManager.$currentStoryIndex
            .assign(to: &$currentStoryIndex)
    }
    
    // MARK: - Lifecycle
    func onAppear() {
        let initialProgress = navigationManager.progressForCurrentStory()
        timerManager.setProgress(initialProgress)
        timerManager.start()
    }
    
    func onDisappear() {
        timerManager.pause()
    }
    
    // MARK: - Gesture Handlers
    func handleTap() {
        moveToNextStory()
    }
    
    func handleSwipeLeft() {
        moveToNextStory()
    }
    
    func handleSwipeRight() {
        moveToPreviousStory()
    }
    
    // MARK: - Progress Handling
    func shouldDismiss() -> Bool {
        progress >= 1.0
    }
    
    func handleProgressChange(_ newValue: CGFloat) {
        let newStoryIndex = Int(newValue * CGFloat(navigationManager.storiesCount))
        
        if newStoryIndex != navigationManager.currentStoryIndex
            && newStoryIndex < navigationManager.storiesCount {
            navigationManager.setStoryIndex(from: newValue)
        }
    }
    
    // MARK: - Private Navigation Methods
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
