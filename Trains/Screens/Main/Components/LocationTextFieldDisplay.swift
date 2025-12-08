import SwiftUI

struct LocationTextFieldDisplay: View {
    // MARK: - Properties
    let placeholder: String
    let city: String
    let station: String
    
    // MARK: - Computed Properties
    private var displayText: String {
        if city.isEmpty && station.isEmpty {
            return ""
        }
        return "\(city) (\(station))"
    }
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 12) {
            Text(displayText.isEmpty ? placeholder : displayText)
                .foregroundStyle(displayText.isEmpty ? .ypGray : .ypBlackUniversal)
            Spacer()
        }
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: 20) {
        LocationTextFieldDisplay(placeholder: "Откуда", city: "", station: "")
        LocationTextFieldDisplay(placeholder: "Откуда", city: "Москва", station: "Киевский вокзал")
    }
    .padding()
}
