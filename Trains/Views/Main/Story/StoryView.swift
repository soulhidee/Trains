import SwiftUI


struct StoryView: View {
    let story: Story

    var body: some View {
        story.backgroundImage
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: 40))
            .padding(.vertical, 51)
            .ignoresSafeArea()
            .overlay(
                VStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 16) {
                        Text(story.title)
                            .font(.system(size: 34, weight: .bold))
                            .lineLimit(2)
                            .foregroundColor(.white)
                        Text(story.description)
                            .font(.system(size: 20, weight: .regular))
                            .lineLimit(3)
                            .foregroundColor(.white)
                    }
                    .padding(.init(top: 0, leading: 16, bottom: 91, trailing: 16))
                }
            )
            .background(.ypBlackUniversal)
    }
}
#Preview {
    StoryView(story: Story.story1)
}
