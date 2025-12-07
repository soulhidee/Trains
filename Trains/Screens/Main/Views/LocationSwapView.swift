// LocationSwapView.swift
import SwiftUI

struct LocationSwapView: View {
    // MARK: - ObservedObject
    @ObservedObject var viewModel: MainViewModel
    
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
            SwapButton {
                viewModel.swapLocations()
            }
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
                city: viewModel.fromCity,
                station: viewModel.fromStation,
                action: { showFromCitySelection = true }
            )
            
            locationButton(
                placeholder: "Куда",
                city: viewModel.toCity,
                station: viewModel.toStation,
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
                    viewModel.fromCity = selectedCity
                    viewModel.fromStation = ""
                    navigationPath.append(SelectionDestination.station(cityName: selectedCity, isFrom: true))
                } else {
                    viewModel.toCity = selectedCity
                    viewModel.toStation = ""
                    navigationPath.append(SelectionDestination.station(cityName: selectedCity, isFrom: false))
                }
            }
            .navigationDestination(for: SelectionDestination.self) { destination in
                switch destination {
                case .station(let cityName, let isFromDest):
                    SelectStationView(cityName: cityName) { station in
                        if isFromDest {
                            viewModel.fromStation = station.title
                            onFromStationSelected?(station)
                        } else {
                            viewModel.toStation = station.title
                            onToStationSelected?(station)
                        }
                        resetSelection()
                    }
                }
            }
        }
    }
    
    // MARK: - Helpers
    private func resetSelection() {
        showFromCitySelection = false
        showToCitySelection = false
        navigationPath = NavigationPath()
    }
}

// MARK: - Preview
#Preview {
    LocationSwapView(viewModel: MainViewModel())
}
