import SwiftUI

struct LocationSwapView: View {
    @State private var fromLocation = ""
    @State private var toLocation = ""
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(spacing: 12) {
                LocationTextField(
                    placeholder: "Откуда",
                    text: $fromLocation)
                
                LocationTextField(
                    placeholder: "Куда",
                    text: $toLocation
                )
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .background(Color.ypWhiteUniversal)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            SwapButton {
                
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.ypBlue)
        )
    }
}

#Preview {
    LocationSwapView()
}
