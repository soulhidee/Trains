//
//  StoryItemView.swift
//  Trains
//
//  Created by Даниил on 29.11.2025.
//

import SwiftUI

struct StoryItemView: View {
    let story: Story
    let isViewed: Bool
    
    var body: some View {
        ZStack {
            story.backgroundImage
                .resizable()
                .scaledToFill()
                .frame(width: 92, height: 140)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .opacity(isViewed ? 0.4 : 1.0)
            
            VStack {
                Spacer()
                Text(story.title)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.white)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 8)
                    .padding(.bottom, 12)
            }
            .frame(width: 92, height: 140)
            
        }
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isViewed ? Color.clear : Color.ypBlue, lineWidth: 4)
        )
    }
}

extension Story {
    var id: String {
        title
    }
}

#Preview {
    StoryItemView(story: Story.story1, isViewed: false)
}
