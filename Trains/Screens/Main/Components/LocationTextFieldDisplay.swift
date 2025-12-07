import SwiftUI

struct LocationTextFieldDisplay: View {
    let placeholder: String
    let city: String
    let station: String
    
    private var displayText: String {
        if city.isEmpty && station.isEmpty {
            return ""
        }
        return "\(city) (\(station))"
    }
    
    var body: some View {
        HStack(spacing: 12) {
            Text(displayText.isEmpty ? placeholder : displayText)
                .foregroundStyle(displayText.isEmpty ? .ypGray : .ypBlackUniversal)
            Spacer()
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        LocationTextFieldDisplay(placeholder: "Откуда", city: "", station: "")
        LocationTextFieldDisplay(placeholder: "Откуда", city: "Москва", station: "Киевский вокзал")
    }
    .padding()
}

