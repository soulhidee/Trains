import SwiftUI

extension CGFloat {
    static let progressBarCornerRadius: CGFloat = 6
    static let progressBarHeight: CGFloat = 6
}

struct ProgressBar: View {
    
    // MARK: - Properties
    let numberOfSections: Int
    let progress: CGFloat
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                
                // MARK: - Background
                RoundedRectangle(cornerRadius: .progressBarCornerRadius)
                    .frame(width: geometry.size.width, height: .progressBarHeight)
                    .foregroundColor(.ypWhiteUniversal)
                
                // MARK: - Progress
                RoundedRectangle(cornerRadius: .progressBarCornerRadius)
                    .frame(
                        width: min(progress * geometry.size.width, geometry.size.width),
                        height: .progressBarHeight
                    )
                    .foregroundColor(.ypBlue)
            }
            .mask {
                MaskView(numberOfSections: numberOfSections)
            }
        }
    }
}

// MARK: - MaskView
private struct MaskView: View {
    
    // MARK: - Properties
    let numberOfSections: Int
    
    // MARK: - Body
    var body: some View {
        HStack {
            ForEach(0..<numberOfSections, id: \.self) { _ in
                MaskFragmentView()
            }
        }
    }
}

// MARK: - MaskFragmentView
private struct MaskFragmentView: View {
    
    // MARK: - Body
    var body: some View {
        RoundedRectangle(cornerRadius: .progressBarCornerRadius)
            .fixedSize(horizontal: false, vertical: true)
            .frame(height: .progressBarHeight)
            .foregroundStyle(.white)
    }
}

// MARK: - Preview
#Preview {
    Color.ypRed
        .ignoresSafeArea()
        .overlay(
            ProgressBar(numberOfSections: 5, progress: 0.5)
                .padding()
        )
}
