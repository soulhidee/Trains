import SwiftUI

// MARK: - StoryContentView
struct StoryContentView: View {
    
    // MARK: - Environment
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - StateObject
    @StateObject private var viewModel: StoryViewModel
    
    // MARK: - Callbacks
    let onStoryViewed: ((Int) -> Void)?
    
    // MARK: - Initialization
    init(
        stories: [Story] = [.story1, .story2, .story3, .story4, .story5],
        startIndex: Int = 0,
        onStoryViewed: ((Int) -> Void)? = nil
    ) {
        _viewModel = StateObject(wrappedValue: StoryViewModel(stories: stories, startIndex: startIndex))
        self.onStoryViewed = onStoryViewed
    }
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            // MARK: - Story View with Gestures
            StoryView(story: viewModel.currentStory)
                .storyGestures(
                    onTap: { viewModel.handleTap() },
                    onSwipeLeft: { viewModel.handleSwipeLeft() },
                    onSwipeRight: { viewModel.handleSwipeRight() }
                )
            
            // MARK: - Progress Bar
            VStack(spacing: 0) {
                ProgressBar(
                    numberOfSections: viewModel.storiesCount,
                    progress: viewModel.combinedProgress
                )
                .padding(.init(top: 28, leading: 12, bottom: 0, trailing: 12))
                
                Spacer()
            }
            
            // MARK: - Close Button
            CloseButton(action: { dismiss() })
                .padding(.top, 57)
                .padding(.trailing, 12)
        }
        .onAppear {
            viewModel.onAppear()
            onStoryViewed?(viewModel.currentStoryIndex)
        }
        .onDisappear {
            viewModel.onDisappear()
        }
        .onChange(of: viewModel.progress) { _, newValue in
            viewModel.handleProgressChange(newValue)
            
            if viewModel.shouldDismiss() {
                dismiss()
            }
        }
        .onChange(of: viewModel.currentStoryIndex) { _, newIndex in
            onStoryViewed?(newIndex)
        }
    }
}

// MARK: - Preview
#Preview {
    StoryContentView()
}
