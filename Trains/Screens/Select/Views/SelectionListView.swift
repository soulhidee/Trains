import SwiftUI

struct SelectionListView: View {
    // MARK: - Properties
    let title: String
    let searchPrompt: String
    let emptyMassage: String
    let items: [String]
    let onSelect: (String) -> Void
    
    @State private var searchText = ""
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Computed
    private var filteredItems: [String] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.localizedStandardContains(searchText) }
        }
    }
    
    // MARK: - Body
    var body: some View {
        List(filteredItems, id: \.self) { item in
            Button {
                onSelect(item)
            } label: {
                SelectionRowView(title: item)
            }
            .buttonStyle(.plain)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.ypWhite)
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: searchPrompt
        )
        .navigationBarBackButtonHidden(true)
        .toolbar {
            backButton
        }
        .overlay {
            emptyStateOverlay
        }
        .environment(\.defaultMinListRowHeight, 60)
        .listStyle(.plain)
        .background(Color.ypWhite)
    }
    
    // MARK: - Private Views
    private var backButton: some ToolbarContent {
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
    
    private var emptyStateOverlay: some View {
        Group {
            if filteredItems.isEmpty && !searchText.isEmpty {
                Text(emptyMassage)
                    .font(.system(size: 24, weight: .bold))
            }
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        SelectionListView(
            title: "Выбор города",
            searchPrompt: "Поиск",
            emptyMassage: "Не удалось найти",
            items: ["Москва", "Спб"],
            onSelect: {_ in }
        )
    }
}
