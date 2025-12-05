
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
                        image
                            .resizable()
                            .scaledToFit()
                            .padding(4)
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

    private var placeholder: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(.ypLightGray)
    }

    private var monogram: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color(.ypLightGray))
            Text(initials(from: title))
                .font(.system(size: 14, weight: .semibold))
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
            logoURLString: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Logo_RZD.svg/256px-Logo_RZD.svg.png",
            title: "РЖД"
        )
        .frame(width: 60, height: 60)

        CarrierLogoView(
            logoURLString: nil,
            title: "Ласточка"
        )
        .frame(width: 60, height: 60)
    }
    .padding()
}
