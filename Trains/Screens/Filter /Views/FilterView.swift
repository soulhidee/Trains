import SwiftUI

struct FilterView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = FilterViewModel()
    
    let initialTimes: Set<DepartureTime>
    let initialTransfers: Bool?
    let onApply: (Set<DepartureTime>, Bool?) -> Void
    
    init(
        initialTimes: Set<DepartureTime> = [],
        initialTransfers: Bool? = nil,
        onApply: @escaping (Set<DepartureTime>, Bool?) -> Void
    ) {
        self.initialTimes = initialTimes
        self.initialTransfers = initialTransfers
        self.onApply = onApply
    }
    
    private var sections: [FilterSection] {
        [
            FilterSection(
                id: "departureTime",
                title: Filter.departureTime,
                items: DepartureTime.allCases.map { time in
                    FilterItem(
                        id: time.rawValue,
                        title: time.title,
                        isSelected: viewModel.selectedTimes.contains(time),
                        selectionType: .checkbox,
                        action: { viewModel.toggleTimeSlot(time) }
                    )
                }
            ),
            FilterSection(
                id: "transfers",
                title: Filter.showTransfers,
                items: TransferOption.allCases.map { option in
                    FilterItem(
                        id: option == .yes ? "yes" : "no",
                        title: option.title,
                        isSelected: viewModel.showTransfers == option.boolValue,
                        selectionType: .radio,
                        action: { viewModel.toggleTransfers(option.boolValue) }
                    )
                }
            )
        ]
    }
    
    var body: some View {
        VStack(spacing: 0) {
            List {
                ForEach(sections) { section in
                    Section {
                        ForEach(section.items) { item in
                            FilterRowView(
                                title: item.title,
                                isSelected: item.isSelected,
                                selectionType: item.selectionType
                            )
                            .listRowBackground(Color.ypWhite)
                            .onTapGesture { item.action() }
                        }
                    } header: {
                        FilterHeaderView(title: section.title)
                            .textCase(nil)
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .environment(\.defaultMinListRowHeight, 60)
            
            PrimaryButton(title: "Применить") {
                onApply(viewModel.selectedTimes, viewModel.showTransfers)
                dismiss()
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .background(Color.ypWhite)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button { dismiss() } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.ypBlack)
                }
            }
        }
        .onAppear {
            viewModel.selectedTimes = initialTimes
            viewModel.showTransfers = initialTransfers
        }
    }
}

#Preview {
    NavigationStack {
        FilterView(
            initialTimes: [.morning, .evening],
            initialTransfers: true
        ) { selectedTimes, showTransfers in
            print("Выбрано время: \(selectedTimes.map { $0.title })")
            print("Пересадки: \(showTransfers.map { $0 ? "да" : "нет" } ?? "не выбрано")")
        }
    }
}
