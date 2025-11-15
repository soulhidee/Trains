import SwiftUI

struct LocationSwapView: View {
    @State private var fromCity = ""
    @State private var fromStation = ""
    @State private var toCity = ""
    @State private var toStation = ""
    
    @State private var showFromCitySelection = false
    @State private var showToCitySelection = false
    @State private var navigationPath = NavigationPath()
    
    private func formattedLocation(city: String, station: String) -> String {
        city.isEmpty && station.isEmpty ? "" : "\(city) (\(station))"
    }
    
    private var fromLocation: String {
        formattedLocation(city: fromCity, station: fromStation)
    }
    
    private var toLocation: String {
        formattedLocation(city: toCity, station: toStation)
    }
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(spacing: 12) {
                Button {
                    showFromCitySelection = true
                } label: {
                    LocationTextField(placeholder: "Откуда", text: .constant(fromLocation))
                }
                .buttonStyle(.plain)
                
                Button {
                    showToCitySelection = true
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
    LocationSwapView()
}
