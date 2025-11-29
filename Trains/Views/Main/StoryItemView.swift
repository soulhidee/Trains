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
                .opacity(isViewed ? 0.5 : 1.0)
            
            VStack {
                Spacer()
                Text(story.title)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.ypWhiteUniversal)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 8)
                    .padding(.bottom, 12)
                    .opacity(isViewed ? 0.5 : 1.0)
            }
            .frame(width: 92, height: 140)
        }
        .frame(width: 92, height: 140)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isViewed ? Color.clear : Color.ypBlue, lineWidth: 4)
        )
    }
}

#Preview {
    StoryItemView(story: Story.story4, isViewed: true)
}
