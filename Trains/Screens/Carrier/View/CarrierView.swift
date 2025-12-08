import SwiftUI

// MARK: - CarrierView
struct CarrierView: View {
    // MARK: - Properties
    let fromCity: String
    let fromStation: String
    let toCity: String
    let toStation: String
    let onBack: () -> Void
    let onServerError: (() -> Void)?
    let onNoInternet: (() -> Void)?
    let fromCode: String
    let toCode: String
    
    // MARK: - State
    @StateObject private var viewModel = CarriersViewModel()
    @State private var showFilter = false
    @State private var showCarrierInfo = false
    @State private var selectedTrip: Carrier?
    @State private var showServerError = false
    @State private var activeFilterCount = 0
    
    // MARK: - Computed Properties
    private var routeTitle: String {
        "\(fromCity)\(fromStation.isEmpty ? "" : " (\(fromStation))") → \(toCity)\(toStation.isEmpty ? "" : " (\(toStation))")"
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            headerSection
            contentSection
            filterButtonSection
        }
        .background(.ypWhite)
        .navigationBarHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .navigationDestination(isPresented: $showFilter) { filterView }
        .navigationDestination(isPresented: $showCarrierInfo) { carrierInfoView }
        .onAppear { setupErrorCallbacks() }
        .task { await loadTrips() }
        .fullScreenCover(isPresented: $showServerError) { ErrorView(image: Image(.errorNoInternet), title: "Нет Интернета") }
        .onChange(of: viewModel.hasFilters) { _, _ in
            activeFilterCount = viewModel.selectedTimes.count + (viewModel.showTransfers != nil ? 1 : 0)
        }
    }
    
    // MARK: - Subviews
    private var headerSection: some View {
        VStack(spacing: 0) {
            Color(.ypWhite).frame(height: 12).ignoresSafeArea(edges: .top)
            HStack {
                Button(action: onBack) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.ypBlack)
                }
                .padding(.leading, 16)
                Spacer()
            }
            .padding(.vertical, 12)
            .padding(.top, 8)
            
            Text(routeTitle)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.ypBlack)
                .padding(.top, 8)
                .padding(.bottom, 16)
                .padding(.horizontal)
        }
        .background(.ypWhite)
    }
    
    private var contentSection: some View {
        ZStack {
            if viewModel.isLoading { loadingView }
            else if let errorMessage = viewModel.errorMessage { errorView(errorMessage) }
            else if viewModel.allCarriers.isEmpty { emptyView }
            else { carriersListView }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ypWhite)
    }
    
    private var filterButtonSection: some View {
        PrimaryButton(
            title: "Уточнить время",
            showIndicator: activeFilterCount > 0,
            action: { showFilter = true }
        )
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
    
    private var loadingView: some View {
        VStack(spacing: 16) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .ypBlack))
                .scaleEffect(1.5)
            Text("Загрузка рейсов...")
                .font(.system(size: 17))
                .foregroundColor(.ypBlack)
        }
    }
    
    private func errorView(_ message: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 48))
                .foregroundColor(.ypRed)
            Text("Ошибка")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.ypBlack)
            Text(message)
                .font(.system(size: 16))
                .foregroundColor(.ypGray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            Button("Попробовать снова") { Task { await loadTrips() } }
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.ypBlue)
                .padding(.top, 8)
        }
    }
    
    private var emptyView: some View {
        VStack {
            Spacer()
            Text("Вариантов нет")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.ypBlack)
            Spacer()
        }
    }
    
    private var carriersListView: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(viewModel.allCarriers) { trip in
                    CarrierCardView(carrierData: trip)
                        .onTapGesture {
                            selectedTrip = trip
                            showCarrierInfo = true
                        }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 100)
        }
    }
    
    private var filterView: some View {
        FilterView(
            initialTimes: viewModel.selectedTimes,
            initialTransfers: viewModel.showTransfers
        ) { times, transfers in
            viewModel.updateFilters(times: times, transfers: transfers)
            activeFilterCount = times.count + (transfers != nil ? 1 : 0)
            Task {
                await viewModel.loadTrips(
                    from: fromCode,
                    to: toCode,
                    fromStation: fromStation,
                    toStation: toStation
                )
            }
        }
    }
    
    private var carrierInfoView: some View {
        Group {
            if let trip = selectedTrip {
                CarrierInfoView(carrier: trip.carrier, onBack: { showCarrierInfo = false })
            }
        }
    }
    
    // MARK: - Private Methods
    private func setupErrorCallbacks() {
        viewModel.setErrorCallbacks(
            onServerError: { showServerError = true },
            onNoInternet: { onNoInternet?() }
        )
    }
    
    private func loadTrips() async {
        guard !fromCode.isEmpty, !toCode.isEmpty else {
            await MainActor.run { viewModel.errorMessage = "Коды станций не найдены" }
            return
        }
        await viewModel.loadTrips(
            from: fromCode,
            to: toCode,
            fromStation: fromStation,
            toStation: toStation
        )
    }
}

// MARK: - Preview
#Preview {
    CarrierView(
        fromCity: "Москва",
        fromStation: "Ярославский вокзал",
        toCity: "Санкт-Петербург",
        toStation: "Балтийский вокзал",
        onBack: {},
        onServerError: nil,
        onNoInternet: nil,
        fromCode: "s2000003",
        toCode: "s9602494"
    )
}
