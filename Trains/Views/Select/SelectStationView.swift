import SwiftUI

struct SelectStationView: View {
    let onSelect: (String) -> Void
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: SelectStationViewModel
    
    init(cityName: String, onSelect: @escaping (String) -> Void) {
        self.onSelect = onSelect
        _viewModel = StateObject(wrappedValue: SelectStationViewModel(cityName: cityName))
    }
    
    var body: some View {
        SelectionListView(
            title: "Выбор станции",
            searchPrompt: "Введите запрос",
            emptyMassage: viewModel.isLoading ? "Загрузка..." : "Станция не найдена",
            items: viewModel.filteredStations.map { $0.title },
            onSelect: onSelect
        )
        .overlay {
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
        .task {
            await viewModel.loadStations()
        }
    }
}

#Preview {
    NavigationStack {
        SelectStationView(cityName: "Москва") { station in
            print("Выбрана: \(station)")
        }
    }
}
