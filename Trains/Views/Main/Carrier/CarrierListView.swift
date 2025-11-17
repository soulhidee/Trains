import SwiftUI

struct CarrierListView: View {
    let fromCity: String
    let toCity: String
    let fromStation: String
    let toStation: String
    
    @Environment(\.dismiss) private var dismiss
    @State private var showFilterView = false
    @State private var selectedTimes: Set<DepartureTime> = []
    @State private var showTransfers: Bool? = nil
    
    private var hasActiveFilters: Bool {
        !selectedTimes.isEmpty || showTransfers != nil
    }
    
    private var filteredCarriers: [Int] {
        if hasActiveFilters {
            return []
        }
        return Array(0..<3)
    }
    
    
    private var routeTitle: String {
        "\(fromCity)\(fromStation.isEmpty ? "" : " (\(fromStation))") → \(toCity)\(toStation.isEmpty ? "" : " (\(toStation))")"
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 16) {
                Text(routeTitle)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.ypBlack)
                    .padding()
                
                if filteredCarriers.isEmpty && hasActiveFilters {
                    Spacer()
                        .frame(height: 221)
                    Text("Вариантов нет")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(.ypBlack)
                    Spacer()
                } else {
                    
                    List {
                        ForEach(0..<3, id: \.self) { index in
                            NavigationLink {
                                CarrierCardView()
                            } label: {
                                Text("Перевозчик \(index + 1)")
                                    .foregroundColor(.ypBlack)
                                    .padding()
                            }
                        }
                        .listRowBackground(Color.ypWhite)
                    }
                    
                    .scrollContentBackground(.hidden)
                    .listStyle(.plain)
                }
            }
            PrimaryButton(title: "Уточнить время", showIndicator: hasActiveFilters) {
                showFilterView = true
            }
            .padding()
            .navigationDestination(isPresented: $showFilterView) {
                FilterView(selectedTimes: $selectedTimes, showTransfers: $showTransfers)
            }
            
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.ypBlack)
                    }
                }
            }
        }
        .background(Color.ypWhite)
    }
}


#Preview {
    NavigationStack {
        CarrierListView(
            fromCity: "Москва",
            toCity: "Санкт Петербург",
            fromStation: "Ярославский вокзал",
            toStation: "Балтийский вокзал"
        )
    }
}
