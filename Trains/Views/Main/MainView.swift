import SwiftUI

struct MainView: View {
    @State private var fromCity = ""
    @State private var fromStation = ""
    @State private var toCity = ""
    @State private var toStation = ""
    
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
                FindButton()
                    .padding(.horizontal)
            }
            
            Spacer()
        }
    }
}

#Preview {
    TabBarView()
}
