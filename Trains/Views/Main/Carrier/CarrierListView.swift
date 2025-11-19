import SwiftUI

struct CarrierListView: View {
    // MARK: - Properties
    let fromCity: String
    let toCity: String
    let fromStation: String
    let toStation: String
    
    private let scheduleList = CarrierModel.schedule
    
    @Environment(\.dismiss) private var dismiss
    @State private var showFilterView = false
    @State private var selectedTimes: Set<DepartureTime> = []
    @State private var showTransfers: Bool? = nil
    
    // MARK: - Computed Properties
    private var filteredScheduleList: [CarrierModel] {
        var result = scheduleList
        
        if !selectedTimes.isEmpty {
            result = result.filter { carrier in
                guard let departureHour = Int(carrier.departure.prefix(2)) else { return false }
                return selectedTimes.contains { time in
                    time.range.contains(departureHour)
                }
            }
        }
        
        if let showTransfers = showTransfers {
            result = result.filter { carrier in
                let hasTransfer = carrier.transferInfo != nil && !carrier.transferInfo!.isEmpty
                return hasTransfer == showTransfers
            }
        }
        
        return result
    }
    
    private var hasActiveFilters: Bool {
        !selectedTimes.isEmpty || showTransfers != nil
    }
    
    private var routeTitle: String {
        "\(fromCity)\(fromStation.isEmpty ? "" : " (\(fromStation))") → \(toCity)\(toStation.isEmpty ? "" : " (\(toStation))")"
    }
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 8) {
                headerView
                contentView
            }
            
            filterButton
        }
        .navigationDestination(isPresented: $showFilterView) {
            FilterView(selectedTimes: $selectedTimes, showTransfers: $showTransfers)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                backButton
            }
        }
        .background(Color.ypWhite)
    }
    
    // MARK: - Subviews
    private var headerView: some View {
        Text(routeTitle)
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.ypBlack)
            .padding(.top, 8)
            .padding(.horizontal)
    }
    
    private var contentView: some View {
        Group {
            if filteredScheduleList.isEmpty {
                emptyStateView
            } else {
                carrierList
            }
        }
    }
    
    private var emptyStateView: some View {
        VStack {
            Spacer()
                .frame(height: 221)
            Text("Вариантов нет")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.ypBlack)
            Spacer()
        }
    }
    
    private var carrierList: some View {
        List {
            ForEach(filteredScheduleList) { carrier in
                carrierRow(carrier)
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .padding(.horizontal, 16)
    }
    
    private func carrierRow(_ carrier: CarrierModel) -> some View {
        ZStack {
            NavigationLink {
                CarrierCardView()
            } label: {
                EmptyView()
            }
            .opacity(0)
            
            ScheduleCardView(schedule: carrier)
                .padding(.vertical, 8)
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.ypWhite)
        .background(Color.ypWhite)
    }
    
    private var filterButton: some View {
        PrimaryButton(title: "Уточнить время", showIndicator: hasActiveFilters) {
            showFilterView = true
        }
        .padding(.horizontal)
        .padding(.bottom, 8)
    }
    
    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.ypBlack)
        }
    }
}

// MARK: - Preview
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
