import SwiftUI

struct MainView: View {
    // MARK: - Environment
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - StateObject
    @StateObject private var viewModel = MainViewModel()
    
    // MARK: - Body
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                storiesSection
                locationSection
                searchButtonSection
                errorSection
                Spacer()
            }
            .background(Color.ypWhite)
        }
        .fullScreenCover(isPresented: $viewModel.showCarrierList) {
            carrierListView
        }
    }
    
    // MARK: - Subviews
    private var storiesSection: some View {
        StoryCollectionView()
            .padding(.top)
    }
    
    private var locationSection: some View {
        LocationSwapView(
            viewModel: viewModel,
            onFromStationSelected: viewModel.setFromStation,
            onToStationSelected: viewModel.setToStation
        )
        .padding(.horizontal)
        .padding(.top)
    }
    
    private var searchButtonSection: some View {
        Group {
            if viewModel.isReadyToSearch {
                PrimaryButton(title: "Найти", customWidth: 150) {
                    viewModel.openCarrierList()
                }
                .padding(.horizontal, 113)
            }
        }
    }
    
    private var errorSection: some View {
        Group {
            if let error = viewModel.errorMessage {
                Text(error)
                    .font(.system(size: 14))
                    .foregroundColor(.ypRed)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
            }
        }
    }
    
    private var carrierListView: some View {
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

// MARK: - Preview
#Preview {
    MainView()
}
