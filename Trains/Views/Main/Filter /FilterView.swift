import SwiftUI

struct FilterView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedTimes: Set<DepartureTime>
    @Binding var showTransfers: Bool?
    
    private var hasAnySelection: Bool {
        !selectedTimes.isEmpty || showTransfers != nil
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
                        isSelected: selectedTimes.contains(time),
                        selectionType: .checkbox,
                        action: {
                            if selectedTimes.contains(time) {
                                selectedTimes.remove(time)
                            } else {
                                selectedTimes.insert(time)
                            }
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
                        isSelected: showTransfers == option.boolValue,
                        selectionType: .radio,
                        action: {
                            if showTransfers == option.boolValue {
                                showTransfers = nil
                            } else {
                                showTransfers = option.boolValue
                            }
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
                            .contentShape(Rectangle())
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
            
            if hasAnySelection {
                PrimaryButton(title: "Применить", action: {
                    dismiss()
                })
                .padding()
            }
        }
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
    @Previewable @State var selectedTimes: Set<DepartureTime> = []
    @Previewable @State var showTransfers: Bool? = nil
    
    NavigationStack {
        FilterView(selectedTimes: $selectedTimes, showTransfers: $showTransfers)
    }
}
