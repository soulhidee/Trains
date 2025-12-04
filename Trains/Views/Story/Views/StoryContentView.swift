import SwiftUI
import Combine

struct StoryContentView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var timerManager: StoryTimerManager
    @StateObject private var navigationManager: StoryNavigationManager
    
    let onStoryViewed: ((Int) -> Void)?
    
    init(stories: [Story] = [.story1, .story2, .story3], startIndex: Int = 0, onStoryViewed: ((Int) -> Void)? = nil) {
        let config = StoryTimerManager.Configuration(storiesCount: stories.count)
        _timerManager = StateObject(wrappedValue: StoryTimerManager(configuration: config))
        _navigationManager = StateObject(wrappedValue: StoryNavigationManager(stories: stories, startIndex: startIndex))
        self.onStoryViewed = onStoryViewed
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoryView(story: navigationManager.currentStory)
                .storyGestures(
                    onTap: handleTap,
                    onSwipeLeft: handleSwipeLeft,
                    onSwipeRight: handleSwipeRight
                )
            
            VStack(spacing: 0) {
                ProgressBar(
                    numberOfSections: navigationManager.storiesCount,
                    progress: combinedProgress
                )
                .padding(.init(top: 28, leading: 12, bottom: 0, trailing: 12))
                
                Spacer()
            }
            
            CloseButton(action: handleClose)
                .padding(.top, 57)
                .padding(.trailing, 12)
        }
        .onAppear {
            let initialProgress = navigationManager.progressForCurrentStory()
            timerManager.setProgress(initialProgress)
            timerManager.start()
            
            onStoryViewed?(navigationManager.currentStoryIndex)
        }
        .onDisappear {
            timerManager.pause()
        }
        .onChange(of: timerManager.progress) { _, newValue in
            handleProgressChange(newValue)
        }
        .onChange(of: navigationManager.currentStoryIndex) { _, newIndex in
            onStoryViewed?(newIndex)
        }
    }
    
    private var combinedProgress: CGFloat {
        let storyProgress = navigationManager.progressForCurrentStory()
        let currentStoryProgress = timerManager.progress - storyProgress
        return storyProgress + currentStoryProgress
    }
    
    private func handleTap() {
        moveToNextStory()
    }
    
    private func handleSwipeLeft() {
        moveToNextStory()
    }
    
    private func handleSwipeRight() {
        moveToPreviousStory()
    }
    
    private func handleClose() {
        dismiss()
    }
    
    private func handleProgressChange(_ newValue: CGFloat) {
        let newStoryIndex = Int(newValue * CGFloat(navigationManager.storiesCount))
        
        if newStoryIndex != navigationManager.currentStoryIndex
            && newStoryIndex < navigationManager.storiesCount {
            navigationManager.setStoryIndex(from: newValue)
        }
        
        if newValue >= 1.0 {
            dismiss()
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

#Preview {
    StoryContentView()
}
