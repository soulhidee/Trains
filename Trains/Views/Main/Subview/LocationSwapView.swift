import SwiftUI

struct LocationSwapView: View {
    @State private var fromLocation = ""
    @State private var toLocation = ""
    @State private var showingFromCityPicker = false
    @State private var showingToCityPicker = false
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(spacing: 12) {
                Button {
                    showingFromCityPicker = true
                } label : {
                    LocationTextField(placeholder: "Откуда", text: $fromLocation)
                }
                .buttonStyle(.plain)
               
                Button {
                    showingToCityPicker = true
                } label : {
                    LocationTextField(placeholder: "Куда", text: $toLocation)
                }
                .buttonStyle(.plain)
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .background(Color.ypWhiteUniversal)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            SwapButton {
                let temp = fromLocation
                fromLocation = toLocation
                toLocation = temp
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.ypBlue)
        )
        .fullScreenCover(isPresented: $showingFromCityPicker) {
            SelectCityView { selectedCity in
                fromLocation = selectedCity
                showingFromCityPicker = false
            }
        }
        .fullScreenCover(isPresented: $showingToCityPicker) {
            SelectCityView { selectedCity in
                toLocation = selectedCity
                showingToCityPicker = false
            }
        }
    }
}

#Preview {
    LocationSwapView()
}
