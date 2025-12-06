import SwiftUI

struct CarrierView: View {
    let fromCity: String
    let fromStation: String
    let toCity: String
    let toStation: String
    let onBack: () -> Void
    let onServerError: (() -> Void)?
    let onNoInternet: (() -> Void)?
    let fromCode: String
    let toCode: String
    
    @StateObject private var viewModel = CarriersViewModel()
    @State private var showFilter = false
    @State private var currentFilters: FilterOptions?
    @State private var showCarrierInfo = false
    @State private var selectedTrip: Carrier?
    @State private var showServerError = false
    
    private var routeTitle: String {
        "\(fromCity)\(fromStation.isEmpty ? "" : " (\(fromStation))") → \(toCity)\(toStation.isEmpty ? "" : " (\(toStation))")"
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Навигационная панель
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
                
                // Заголовок с маршрутом
                Text(routeTitle)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.ypBlack)
                    .padding(.top, 8)
                    .padding(.bottom, 16)
                    .padding(.horizontal)
            }
            .background(.ypWhite)
            
            // Основной контент
            if viewModel.isLoading {
                VStack(spacing: 16) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .ypBlack))
                        .scaleEffect(1.5)
                    
                    Text("Загрузка рейсов...")
                        .font(.system(size: 17))
                        .foregroundColor(.ypBlack)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.ypWhite)
            } else if let errorMessage = viewModel.errorMessage {
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 48))
                        .foregroundColor(.ypRed)
                    
                    Text("Ошибка")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.ypBlack)
                    
                    Text(errorMessage)
                        .font(.system(size: 16))
                        .foregroundColor(.ypGray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                    
                    Button("Попробовать снова") {
                        Task {
                            await loadTrips()
                        }
                    }
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.ypBlue)
                    .padding(.top, 8)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.ypWhite)
            } else if viewModel.allCarriers.isEmpty {
                ZStack(alignment: .bottom) {
                    VStack {
                        Spacer()
                        Text("Вариантов нет")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.ypBlack)
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.ypWhite)

                    VStack {
                        Button(action: { showFilter = true }) {
                            Text("Уточнить время")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.ypWhiteUniversal)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                                .background(.ypBlue)
                                .cornerRadius(16)
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                    }
                }
            } else {
                ZStack(alignment: .bottom) {
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(viewModel.allCarriers) { trip in
                                CarrierCardView(trip: trip)
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
                    .background(.ypWhite)
                    
                    VStack {
                        Button(action: { showFilter = true }) {
                            Text("Уточнить время")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.ypWhiteUniversal)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                                .background(.ypBlue)
                                .cornerRadius(16)
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 16)
                    }
                }
                .background(.ypWhite)
            }
        }
        .navigationDestination(isPresented: $showFilter) {
           FilterView()
        }
        .navigationDestination(isPresented: $showCarrierInfo) {
            if let trip = selectedTrip {
                CarrierInfoView(
                    carrier: trip.carrier,
                    onBack: { showCarrierInfo = false }
                )
            } else {
                CarrierInfoView(
                    carrier: CarrierInfo(title: "", logo: nil, code: nil, email: nil, phone: nil, url: nil, contacts: nil),
                    onBack: { showCarrierInfo = false }
                )
            }
        }
        .onAppear {
            viewModel.setErrorCallbacks(
                onServerError: {
                    showServerError = true
                },
                onNoInternet: {
                    onNoInternet?()
                }
            )
        }
        .task { await loadTrips() }
        .navigationBarHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .fullScreenCover(isPresented: $showServerError) {
            ErrorView(image: Image(.errorNoInternet), title: "Нет Интернета")
        }
        .background(.ypWhite)
    }
    
    private func loadTrips() async {
        // Проверяем что коды уже есть
        print("🔍 DEBUG: fromCode = '\(fromCode)', toCode = '\(toCode)'")
        print("🔍 DEBUG: fromStation = '\(fromStation)', toStation = '\(toStation)'")
        
        guard !fromCode.isEmpty, !toCode.isEmpty else {
            await MainActor.run {
                viewModel.errorMessage = "Коды станций не найдены"
            }
            return
        }
        
        // Используем переданные коды напрямую
        await viewModel.loadTrips(
            from: fromCode,
            to: toCode,
            fromStation: fromStation,
            toStation: toStation
        )
        
        print("🔍 DEBUG: Загружено рейсов: \(viewModel.allCarriers.count)")
    }
}

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
    .background()
}
