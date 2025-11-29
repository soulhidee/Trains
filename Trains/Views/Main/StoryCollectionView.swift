//
//  StoryCollectionView.swift
//  Trains
//
//  Created by Даниил on 29.11.2025.
//

import SwiftUI

struct StoryCollectionView: View {
    @State private var viewedStories: Set<String> = []
    @State private var selectedStory: Story?
    @State private var showStoryContent = false
    
    private let stories: [Story] = [Story.story1, Story.story2, Story.story3]
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    StoryCollectionView()
}
