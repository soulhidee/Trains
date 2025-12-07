import SwiftUI

//Используем Москва (Киевский вокзал) -> Санкт-Петербург (Московский вокзал)

struct MainView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                StoryCollectionView()
                    .padding(.top)
                
                LocationSwapView(
                    fromCity: $viewModel.fromCity,
                    fromStation: $viewModel.fromStation,
                    toCity: $viewModel.toCity,
                    toStation: $viewModel.toStation,
                    onFromStationSelected: { station in
                        viewModel.setFromStation(station)
                    },
                    onToStationSelected: { station in
                        viewModel.setToStation(station)
                    }
                )
                .padding(.horizontal)
                .padding(.top)
                
                if viewModel.isReadyToSearch {
                    PrimaryButton(title: "Найти", customWidth: 150) {
                        viewModel.openCarrierList()
                    }
                    .padding(.horizontal, 113)
                }
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(.system(size: 14))
                        .foregroundColor(.ypRed)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
            }
            .background(Color.ypWhite)
        }
        .fullScreenCover(isPresented: $viewModel.showCarrierList) {
            NavigationStack {
                CarrierView(
                    fromCity: viewModel.fromCity,
                    fromStation: viewModel.fromStation,
                    toCity: viewModel.toCity,
                    toStation: viewModel.toStation,
                    onBack: {
                        viewModel.closeCarrierList()
                        dismiss()
                    },
                    onServerError: nil,
                    onNoInternet: nil,
                    fromCode: viewModel.fromCode,
                    toCode: viewModel.toCode
                )
            }
        }
    }
}

#Preview {
    MainView()
}
