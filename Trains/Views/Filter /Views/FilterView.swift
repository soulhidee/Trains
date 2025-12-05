import SwiftUI

struct FilterView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = FilterViewModel()
    
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
                        action: {
                            viewModel.toggleTimeSlot(time)
                        }
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
                        action: {
                            viewModel.toggleTransfers(option.boolValue)
                        }
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
                            .onTapGesture {
                                item.action()
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
            
            if viewModel.hasAnySelection {
                PrimaryButton(title: "Применить", action: {
                    viewModel.applyFilters()
                    dismiss()
                })
                .padding()
            }
        }
        .background(Color.ypWhite)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.ypBlack)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        FilterView()
    }
}
