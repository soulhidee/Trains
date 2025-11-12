import SwiftUI

struct LocationSwapView: View {
    @State private var fromCity = ""
    @State private var fromStation = ""
    @State private var toCity = ""
    @State private var toStation = ""
    
    
    private var fromLocation: String {
        fromStation.isEmpty ? fromCity : fromStation
    }
    
    private var toLocation: String {
        toStation.isEmpty ? toCity : toStation
    }
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(spacing: 12) {
                Button {
                } label: {
                    LocationTextField(placeholder: "Откуда", text: .constant(fromLocation))
                }
                .buttonStyle(.plain)
                
                Button {
                } label: {
                    LocationTextField(placeholder: "Куда", text: .constant(toLocation))
                }
                .buttonStyle(.plain)
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .background(Color.ypWhiteUniversal)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            SwapButton {
                swap(&fromCity, &toCity)
                swap(&fromStation, &toStation)
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
