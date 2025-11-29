import SwiftUI
import Combine

struct StoryContentView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var timerManager: StoryTimerManager
    @StateObject private var navigationManager: StoryNavigationManager
    
    // MARK: - Computed Properties
    private var combinedProgress: CGFloat {
        let storyProgress = navigationManager.progressForCurrentStory()
        let currentStoryProgress = timerManager.progress - storyProgress
        return storyProgress + currentStoryProgress
    }
    
    init(stories: [Story] = [.story1, .story2, .story3]) {
        let config = StoryTimerManager.Configuration(storiesCount: stories.count)
        _timerManager = StateObject(wrappedValue: StoryTimerManager(configuration: config))
        _navigationManager = StateObject(wrappedValue: StoryNavigationManager(stories: stories))
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
            timerManager.start()
        }
        .onDisappear {
            timerManager.pause()
        }
        .onChange(of: timerManager.progress) { oldValue, newValue in
            handleProgressChange(newValue)
        }
    }
    
   
    
    // MARK: - Handlers
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
    
    private func handleProgressChange(_ newProgress: CGFloat) {
        let newStoryIndex = Int(newProgress * CGFloat(navigationManager.storiesCount))
        
        if newStoryIndex != navigationManager.currentStoryIndex {
            navigationManager.setStoryIndex(from: newProgress)
        }
        
        if newProgress >= 1.0 {
            timerManager.setProgress(0)
            navigationManager.setStoryIndex(from: 0)
        }
    }
    
    // MARK: - Private Methods
    private func moveToNextStory() {
        navigationManager.nextStory()
        updateTimerForCurrentStory()
    }
    
    private func moveToPreviousStory() {
        navigationManager.previousStory()
        updateTimerForCurrentStory()
    }
    
    private func updateTimerForCurrentStory() {
        withAnimation {
            timerManager.setProgress(navigationManager.progressForCurrentStory())
        }
        timerManager.reset()
    }
}

#Preview {
    StoryContentView()
}
