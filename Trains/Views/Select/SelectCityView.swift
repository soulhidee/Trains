import SwiftUI

struct SelectCityView: View {
    let onSelect: (String) -> Void
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = SelectCityViewModel()
    
    var body: some View {
        SelectionListView(
            title: "Выбор города",
            searchPrompt: "Введите запрос",
            emptyMassage: viewModel.isLoading ? "Загрузка..." : "Город не найден",
            items: viewModel.filteredCities.map { $0.title },
            onSelect: onSelect
        )
        .overlay {
            if viewModel.isLoading && viewModel.cities.isEmpty {
                VStack(spacing: 16) {
                    ProgressView()
                    Text("Загрузка городов...")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.ypGray)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.ypWhite.opacity(0.9))
            }
        }
        .task {
            await viewModel.loadCities()
        }
    }
}

#Preview {
    NavigationStack {
        SelectCityView { city in
            print("Выбран: \(city)")
        }
    }
}
