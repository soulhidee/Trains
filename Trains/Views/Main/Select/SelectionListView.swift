import SwiftUI

struct SelectionListView: View {
    let title: String
    let searchPrompt: String
    let emptyMassage: String
    let items: [String]
    let onSelect: (String) -> Void
    
    @State private var searchText = ""
    @Environment(\.dismiss) private var dismiss
    
    private var filterItems: [String] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.localizedStandardContains(searchText) }
        }
    }
    
    var body: some View {
        List(filterItems, id: \.self) { item in
            Button {
                onSelect(item)
            } label: {
                RowSelectionView(title: item)
            }
            .buttonStyle(.plain)
            .listRowSeparator(.hidden)
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: searchPrompt)
        .overlay {
            if filterItems.isEmpty && !searchText.isEmpty {
                Text(emptyMassage)
                    .font(.system(size: 24, weight: .bold))
            }
        }
        .environment(\.defaultMinListRowHeight, 60)
        .listStyle(.plain)
        
    }
}



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
