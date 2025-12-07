import SwiftUI

struct CarrierLogoView: View {
    let logoURLString: String?
    let title: String
    
    var body: some View {
        Group {
            if let urlString = logoURLString?.replacingOccurrences(of: "http://", with: "https://"),
               let url = URL(string: urlString) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        placeholder
                    case .success(let image):
                        imageContainer(image: image)
                    case .failure:
                        monogram
                    @unknown default:
                        placeholder
                    }
                }
            } else {
                monogram
            }
        }
    }
    
    private func imageContainer(image: Image) -> some View {
        ZStack {
            Color(.ypWhiteUniversal)
            image
                .resizable()
                .scaledToFill()
                .frame(width: 38, height: 38, alignment: .leading)
                .scaleEffect(0.51, anchor: .leading)
                .clipped()
                .scaleEffect(1, anchor: .center)
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var placeholder: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(.ypLightGray)
    }
    
    private var monogram: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.ypWhiteUniversal))
            Text(initials(from: title))
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(.ypBlack)
        }
    }
    
    private func initials(from title: String) -> String {
        let parts = title.split(separator: " ")
        let first = parts.first?.first.map { String($0) } ?? ""
        let second = parts.dropFirst().first?.first.map { String($0) } ?? ""
        return (first + second).uppercased()
    }
}

#Preview {
    VStack(spacing: 20) {
        CarrierLogoView(
            logoURLString: "https://yastat.net/s3/rasp/media/data/company/logo/logo.gif",
            title: "РЖД"
        )
        .frame(width: 38, height: 38)
        
        CarrierLogoView(
            logoURLString: nil,
            title: "Ласточка"
        )
        .frame(width: 60, height: 60)
    }
    .padding()
    .background(.ypBlackUniversal)
}
