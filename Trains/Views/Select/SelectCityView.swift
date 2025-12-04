import SwiftUI

struct SelectCityView: View {
    let onSelect: (String) -> Void
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = SelectCityViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                VStack(spacing: 16) {
                    Spacer()
                    ProgressView()
                    Text("Загрузка городов...")
                        .font(. system(size: 14, weight: .regular))
                        .foregroundColor(.ypGray)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                . background(Color.ypWhite)
            } else {
                SelectionListView(
                    title: "Выбор города",
                    searchPrompt: "Введите запрос",
                    emptyMassage: "Город не найден",
                    items: viewModel.filteredCities.map { $0.title },
                    onSelect: onSelect
                )
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
