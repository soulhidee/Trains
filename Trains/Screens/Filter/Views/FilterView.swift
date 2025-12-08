import SwiftUI

struct FilterView: View {
    // MARK: - Environment
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - StateObject
    @StateObject private var viewModel = FilterViewModel()
    
    // MARK: - Properties
    let initialTimes: Set<DepartureTime>
    let initialTransfers: Bool?
    let onApply: (Set<DepartureTime>, Bool?) -> Void
    
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
                        selectionType: .checkbox
                    )
                },
                itemTypes: DepartureTime.allCases.map { .timeSlot($0) }
            ),
            FilterSection(
                id: "transfers",
                title: Filter.showTransfers,
                items: TransferOption.allCases.map { option in
                    FilterItem(
                        id: option == .yes ? "yes" : "no",
                        title: option.title,
                        isSelected: viewModel.showTransfers == option.boolValue,
                        selectionType: .radio
                    )
                },
                itemTypes: TransferOption.allCases.map { .transfer($0) }
            )
        ]
    }
    
    // MARK: - Init
    init(
        initialTimes: Set<DepartureTime> = [],
        initialTransfers: Bool? = nil,
        onApply: @escaping (Set<DepartureTime>, Bool?) -> Void
    ) {
        self.initialTimes = initialTimes
        self.initialTransfers = initialTransfers
        self.onApply = onApply
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            listSection
            applyButtonSection
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
        .task {
            viewModel.selectedTimes = initialTimes
            viewModel.showTransfers = initialTransfers
        }
    }
    
    // MARK: - Subviews
    private var listSection: some View {
        List {
            ForEach(Array(sections.enumerated()), id: \.element.id) { _, section in
                Section {
                    ForEach(Array(section.items.enumerated()), id: \.element.id) { itemIndex, item in
                        FilterRowView(
                            title: item.title,
                            isSelected: item.isSelected,
                            selectionType: item.selectionType
                        )
                        .listRowBackground(Color.ypWhite)
                        .onTapGesture {
                            handleItemTap(section: section, itemIndex: itemIndex)
                        }
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
    }
    
    private var applyButtonSection: some View {
        PrimaryButton(title: "Применить") {
            onApply(viewModel.selectedTimes, viewModel.showTransfers)
            dismiss()
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
    
    // MARK: - Private Methods
    private func handleItemTap(section: FilterSection, itemIndex: Int) {
        guard itemIndex < section.itemTypes.count else { return }
        
        let itemType = section.itemTypes[itemIndex]
        switch itemType {
        case .timeSlot(let time):
            viewModel.toggleTimeSlot(time)
        case .transfer(let option):
            viewModel.toggleTransfers(option.boolValue)
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        FilterView(
            initialTimes: [.morning, .evening],
            initialTransfers: true
        ) { _, _ in }
    }
}
