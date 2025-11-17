import SwiftUI

struct MainView: View {
    @State private var fromCity = ""
    @State private var fromStation = ""
    @State private var toCity = ""
    @State private var toStation = ""
    @State private var showCarrierList = false
    
    private var isReadyToSearch: Bool {
        !fromCity.isEmpty && !toCity.isEmpty
    }
    
    var body: some View {
        VStack(spacing: 16) {
            LocationSwapView(
                fromCity: $fromCity,
                fromStation: $fromStation,
                toCity: $toCity,
                toStation: $toStation
            )
            .padding(.horizontal)
            .padding(.top)
            
            if isReadyToSearch {
                PrimaryButton(title: "Найти") {
                    showCarrierList = true
                }
                
                .padding(.horizontal, 112.5)
            }
            
            Spacer()
        }
        .background(Color.ypWhite)
        .fullScreenCover(isPresented: $showCarrierList) {
            NavigationStack {
                CarrierListView(
                    fromCity: fromCity,
                    toCity: toCity,
                    fromStation: fromStation,
                    toStation: toStation)
            }
        }
    }
}

#Preview {
    TabBarView()
}
