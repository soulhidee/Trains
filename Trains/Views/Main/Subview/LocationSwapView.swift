import SwiftUI

struct LocationSwapView: View {
    @State private var fromCity = ""
    @State private var fromStation = ""
    @State private var toCity = ""
    @State private var toStation = ""
    
    @Binding var path: NavigationPath
    
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
                    path.append(NavigationRoute.selectFromCity)
                } label: {
                    LocationTextField(placeholder: "Откуда", text: .constant(fromLocation))
                }
                .buttonStyle(.plain)
               
                Button {
                    path.append(NavigationRoute.selectToCity)
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
        .navigationDestination(for: NavigationRoute.self) { route in
            switch route {
            case .selectFromCity:
                SelectCityView { city in
                    fromCity = city
                    fromStation = ""
                    path.append(NavigationRoute.selectFromStation(city: city))
                }
                .navigationBarBackButtonHidden(false)
                        .toolbar(.hidden, for: .tabBar)
            case .selectToCity:
                SelectCityView { city in
                    toCity = city
                    toStation = ""
                    path.append(NavigationRoute.selectToStation(city: city))
                }
                .navigationBarBackButtonHidden(false)
                        .toolbar(.hidden, for: .tabBar)
            case .selectFromStation(let city):
                SelectStationView(cityName: city) { station in
                    fromStation = station
                    path.removeLast(2)
                }
                .navigationBarBackButtonHidden(false)
                        .toolbar(.hidden, for: .tabBar)
            case .selectToStation(let city):
                SelectStationView(cityName: city) { station in
                    toStation = station
                    path.removeLast(2)
                }
                .navigationBarBackButtonHidden(false)
                        .toolbar(.hidden, for: .tabBar)
            }
        }
    }
}

#Preview {
    LocationSwapView(path: .constant(NavigationPath()))
}
