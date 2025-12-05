import SwiftUI

struct CarrierView: View {
    let fromCity: String
    let fromStation: String
    let toCity: String
    let toStation: String
    let onBack: () -> Void
    let onServerError: (() -> Void)?
    let onNoInternet: (() -> Void)?
    
    @StateObject private var viewModel = CarriersViewModel()
    @State private var showFilter = false
    @State private var currentFilters: FilterOptions?
    @State private var showCarrierInfo = false
    @State private var selectedTrip: Carrier?
    // Локальный показ "Нет интернета" убираем, централизуем через MainTabView
    @State private var showServerError = false
    
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
                
                // Заголовок с маршрутом (как в макете)
                HStack(alignment: .center, spacing: 8) {
                    Text("\(fromCity) (\(fromStation))")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.ypBlack)
                    Image(systemName: "arrow.right")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.ypBlack)
                    Text("\(toCity) (\(toStation))")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.ypBlack)
                }
                .padding(.bottom, 16)
            }
            .background(.ypWhite)
            
            // Основной контент
            if viewModel.isLoading {
                // Индикатор загрузки
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
                // Сообщение об ошибке
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
            } else if viewModel.trips.isEmpty {
                // Экран "Вариантов нет" (без дублирования верхней панели и маршрута)
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

                    // Кнопка "Уточнить время" внизу
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
                // Список рейсов с кнопкой поверх
                ZStack(alignment: .bottom) {
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(viewModel.trips) { trip in
                                CarrierCardView(trip: trip)
                                    .onTapGesture {
                                        selectedTrip = trip
                                        showCarrierInfo = true
                                    }
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                        .padding(.bottom, 100) // Отступ для кнопки внизу
                    }
                    .background(.ypWhite)
                    
                    // Кнопка "Уточнить время" поверх скролла
                    VStack {
                        Button(action: {
                            showFilter = true
                        }) {
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
        .background(Color("AppWhite"))
    }
    
    private func loadTrips() async {
        do {
            let apikey = Secrets.apiKey

            async let fromStationsAsync = APIClient.shared.fetchStations(inCityTitle: fromCity, apikey: apikey)
            async let toStationsAsync = APIClient.shared.fetchStations(inCityTitle: toCity, apikey: apikey)
            let (fromStations, toStations) = try await (fromStationsAsync, toStationsAsync)
            
            // Находим коды станций по названиям
            let fromCode = fromStations.first { $0.title == fromStation }?.yandexCode
            let toCode = toStations.first { $0.title == toStation }?.yandexCode
            
            guard let fromCode = fromCode, let toCode = toCode else {
                await MainActor.run {
                    viewModel.errorMessage = "Не удалось найти коды станций"
                }
                return
            }
            
            await viewModel.loadTrips(
                from: fromCode,
                to: toCode,
                fromStation: fromStation,
                toStation: toStation
            )
        } catch {
            await MainActor.run {
                if error.localizedDescription.contains("network") || 
                   error.localizedDescription.contains("internet") ||
                   error.localizedDescription.contains("offline") {
                    onNoInternet?()
                } else {
                    viewModel.errorMessage = "Ошибка сервера"
                }
            }
        }
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
        onNoInternet: nil
    )
    .background()
}
