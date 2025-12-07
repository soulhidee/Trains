import SwiftUI

struct SelectStationView: View {
    // MARK: - Properties
    let onSelect: (DirectoryStation) -> Void
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: SelectStationViewModel
    
    // MARK: - Init
    init(cityName: String, onSelect: @escaping (DirectoryStation) -> Void) {
        self.onSelect = onSelect
        _viewModel = StateObject(wrappedValue: SelectStationViewModel(cityName: cityName))
    }
    
    // MARK: - Body
    var body: some View {
        List(viewModel.filteredStations, id: \.title) { station in
            Button {
                onSelect(station)
            } label: {
                SelectionRowView(title: station.title)
            }
            .buttonStyle(.plain)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.ypWhite)
        }
        .navigationTitle("Выбор станции")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Введите запрос")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            backButton
        }
        .overlay {
            emptyOrLoadingOverlay
        }
        .environment(\.defaultMinListRowHeight, 60)
        .listStyle(.plain)
        .background(Color.ypWhite)
        .task {
            await viewModel.loadStations()
        }
    }
    
    // MARK: - Toolbar Items
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
    
    // MARK: - Overlay Views
    private var emptyOrLoadingOverlay: some View {
        Group {
            if viewModel.filteredStations.isEmpty && !viewModel.searchText.isEmpty {
                Text(viewModel.isLoading ? "Загрузка..." : "Станция не найдена")
                    .font(.system(size: 24, weight: .bold))
            }
            
            if viewModel.isLoading && viewModel.stations.isEmpty {
                VStack(spacing: 16) {
                    ProgressView()
                    Text("Загрузка станций...")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.ypGray)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.ypWhite.opacity(0.9))
            }
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        SelectStationView(cityName: "Москва") { station in
            print("Выбрана: \(station.title), код: \(station.yandexCode ?? "нет")")
        }
    }
}
