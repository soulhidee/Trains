import SwiftUI

struct StoryContentView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: StoryViewModel
    
    let onStoryViewed: ((Int) -> Void)?
    
    init(stories: [Story] = [.story1, .story2, .story3], startIndex: Int = 0, onStoryViewed: ((Int) -> Void)? = nil) {
        _viewModel = StateObject(wrappedValue: StoryViewModel(stories: stories, startIndex: startIndex))
        self.onStoryViewed = onStoryViewed
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoryView(story: viewModel.currentStory)
                .storyGestures(
                    onTap: { viewModel.handleTap() },
                    onSwipeLeft: { viewModel.handleSwipeLeft() },
                    onSwipeRight: { viewModel.handleSwipeRight() }
                )
            
            VStack(spacing: 0) {
                ProgressBar(
                    numberOfSections: viewModel.storiesCount,
                    progress: viewModel.combinedProgress
                )
                .padding(.init(top: 28, leading: 12, bottom: 0, trailing: 12))
                
                Spacer()
            }
            
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

#Preview {
    StoryContentView()
}
