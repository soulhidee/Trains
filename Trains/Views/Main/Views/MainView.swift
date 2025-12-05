import SwiftUI

struct MainView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            StoryCollectionView()
                .padding(.top)
            
            LocationSwapView(
                fromCity: $viewModel.fromCity,
                fromStation: $viewModel.fromStation,
                toCity: $viewModel.toCity,
                toStation: $viewModel.toStation
            )
            .padding(.horizontal)
            .padding(.top)
            
            if viewModel.isReadyToSearch {
                PrimaryButton(title: "Найти", customWidth: 150) {
                    viewModel.openCarrierList()
                }
                .padding(.horizontal, 113)
            }
            
            Spacer()
            
        }
        .background(Color.ypWhite)
        .fullScreenCover(isPresented: $viewModel.showCarrierList) {
            NavigationStack {
                CarrierView(
                    fromCity: viewModel.fromCity,
                    fromStation: viewModel.fromStation,
                    toCity: viewModel.toCity,
                    toStation: viewModel.toStation,
                    onBack: { dismiss() },
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
