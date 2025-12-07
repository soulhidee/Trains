import SwiftUI

struct LocationSwapView: View {
    // MARK: - Bindings
    @Binding var fromCity: String
    @Binding var fromStation: String
    @Binding var toCity: String
    @Binding var toStation: String
    
    // MARK: - Callbacks
    var onFromStationSelected: ((DirectoryStation) -> Void)?
    var onToStationSelected: ((DirectoryStation) -> Void)?
    
    // MARK: - State
    @State private var showFromCitySelection = false
    @State private var showToCitySelection = false
    @State private var navigationPath = NavigationPath()
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 16) {
            locationsStack
            SwapButton { swapLocations() }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.ypBlue)
        )
        .fullScreenCover(isPresented: $showFromCitySelection) { citySelection(isFrom: true) }
        .fullScreenCover(isPresented: $showToCitySelection) { citySelection(isFrom: false) }
    }
    
    // MARK: - Subviews
    private var locationsStack: some View {
        VStack(spacing: 28) {
            locationButton(
                placeholder: "Откуда",
                city: fromCity,
                station: fromStation,
                action: { showFromCitySelection = true }
            )
            
            locationButton(
                placeholder: "Куда",
                city: toCity,
                station: toStation,
                action: { showToCitySelection = true }
            )
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 16)
        .background(Color.ypWhiteUniversal)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    private func locationButton(placeholder: String, city: String, station: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            LocationTextFieldDisplay(
                placeholder: placeholder,
                city: city,
                station: station
            )
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
    
    private func citySelection(isFrom: Bool) -> some View {
        NavigationStack(path: $navigationPath) {
            SelectCityView { selectedCity in
                if isFrom {
                    fromCity = selectedCity
                    fromStation = ""
                    navigationPath.append(SelectionDestination.station(cityName: selectedCity, isFrom: true))
                } else {
                    toCity = selectedCity
                    toStation = ""
                    navigationPath.append(SelectionDestination.station(cityName: selectedCity, isFrom: false))
                }
            }
            .navigationDestination(for: SelectionDestination.self) { destination in
                switch destination {
                case .station(let cityName, let isFromDest):
                    SelectStationView(cityName: cityName) { station in
                        if isFromDest {
                            fromStation = station.title
                            onFromStationSelected?(station)
                        } else {
                            toStation = station.title
                            onToStationSelected?(station)
                        }
                        resetSelection()
                    }
                }
            }
        }
    }
    
    // MARK: - Helpers
    private func swapLocations() {
        swap(&fromCity, &toCity)
        swap(&fromStation, &toStation)
    }
    
    private func resetSelection() {
        showFromCitySelection = false
        showToCitySelection = false
        navigationPath = NavigationPath()
    }
}

// MARK: - Preview
#Preview {
    @Previewable @State var fromCity = ""
    @Previewable @State var fromStation = ""
    @Previewable @State var toCity = ""
    @Previewable @State var toStation = ""
    
    LocationSwapView(
        fromCity: $fromCity,
        fromStation: $fromStation,
        toCity: $toCity,
        toStation: $toStation
    )
}
