import SwiftUI

struct CarrierInfoLogoView: View {
    // MARK: - Properties
    let logoURLString: String?
    let title: String
    
    // MARK: - Body
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
    
    // MARK: - Subviews
    private var placeholder: some View {
        Color(.ypLightGray)
    }
    
    private var monogram: some View {
        ZStack {
            Color(.ypWhite)
            Text(initials(from: title))
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.ypWhite)
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    // MARK: - Private Methods
    private func initials(from title: String) -> String {
        let parts = title.split(separator: " ")
        let first = parts.first?.first.map { String($0) } ?? ""
        let second = parts.dropFirst().first?.first.map { String($0) } ?? ""
        return (first + second).uppercased()
    }
}

// MARK: - Preview
#Preview {
    CarrierInfoLogoView(logoURLString: nil, title: "ОАО «РЖД»")
        .frame(width: 100, height: 100)
        .padding()
}
