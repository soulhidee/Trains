import SwiftUI

struct LocationSwapView: View {
    @Binding var fromCity: String
    @Binding var fromStation: String
    @Binding var toCity: String
    @Binding var toStation: String
    
    @State private var showFromCitySelection = false
    @State private var showToCitySelection = false
    @State private var navigationPath = NavigationPath()
    
    private func formattedLocation(city: String, station: String) -> String {
        if city.isEmpty && station.isEmpty {
            return ""
        }
        return "\(city) (\(station))"
    }
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(spacing: 12) {
                Button {
                    showFromCitySelection = true
                } label: {
                    LocationTextFieldDisplay(
                        placeholder: "Откуда",
                        city: fromCity,
                        station: fromStation
                    )
                }
                .buttonStyle(.plain)
                
                Button {
                    showToCitySelection = true
                } label: {
                    LocationTextFieldDisplay(
                        placeholder: "Куда",
                        city: toCity,
                        station: toStation
                    )
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
        .fullScreenCover(isPresented: $showFromCitySelection) {
            NavigationStack(path: $navigationPath) {
                SelectCityView { selectedCity in
                    fromCity = selectedCity
                    fromStation = ""
                    navigationPath.append(SelectionDestination.station(cityName: selectedCity, isFrom: true))
                }
                .navigationDestination(for: SelectionDestination.self) { destination in
                    switch destination {
                    case .station(let cityName, let isFrom):
                        SelectStationView(cityName: cityName) { selectedStation in
                            if isFrom {
                                fromStation = selectedStation
                            } else {
                                toStation = selectedStation
                            }
                            showFromCitySelection = false
                            showToCitySelection = false
                            navigationPath = NavigationPath()
                        }
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $showToCitySelection) {
            NavigationStack(path: $navigationPath) {
                SelectCityView { selectedCity in
                    toCity = selectedCity
                    toStation = ""
                    navigationPath.append(SelectionDestination.station(cityName: selectedCity, isFrom: false))
                }
                .navigationDestination(for: SelectionDestination.self) { destination in
                    switch destination {
                    case .station(let cityName, let isFrom):
                        SelectStationView(cityName: cityName) { selectedStation in
                            if isFrom {
                                fromStation = selectedStation
                            } else {
                                toStation = selectedStation
                            }
                            showFromCitySelection = false
                            showToCitySelection = false
                            navigationPath = NavigationPath()
                        }
                    }
                }
            }
        }
    }
}

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
