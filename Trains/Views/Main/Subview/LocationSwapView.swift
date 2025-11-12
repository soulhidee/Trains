import SwiftUI

struct LocationSwapView: View {
    @State private var fromCity = ""
    @State private var fromStation = ""
    @State private var toCity = ""
    @State private var toStation = ""
    
    @State private var showingFromCityPicker = false
    @State private var showingToCityPicker = false
    @State private var showingFromStationPicker = false
    @State private var showingToStationPicker = false
    
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
                    showingFromCityPicker = true
                } label: {
                    LocationTextField(placeholder: "Откуда", text: .constant(fromLocation))
                }
                .buttonStyle(.plain)
               
                Button {
                    showingToCityPicker = true
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
        .fullScreenCover(isPresented: $showingFromCityPicker) {
            SelectCityView { selectedCity in
                fromCity = selectedCity
                fromStation = ""
                showingFromCityPicker = false
                showingFromStationPicker = true
            }
        }
        .fullScreenCover(isPresented: $showingToCityPicker) {
            SelectCityView { selectedCity in
                toCity = selectedCity
                toStation = ""
                showingToCityPicker = false
                showingToStationPicker = true
            }
        }
        .fullScreenCover(isPresented: $showingFromStationPicker) {
            if !fromCity.isEmpty {
                SelectStationView(cityName: fromCity) { selectedStation in
                    fromStation = selectedStation
                    showingFromStationPicker = false
                }
            }
        }
        .fullScreenCover(isPresented: $showingToStationPicker) {
            if !toCity.isEmpty {
                SelectStationView(cityName: toCity) { selectedStation in
                    toStation = selectedStation
                    showingToStationPicker = false
                }
            }
        }
    }
}

#Preview {
    LocationSwapView()
}
