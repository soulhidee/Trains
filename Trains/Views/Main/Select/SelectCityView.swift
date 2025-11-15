import SwiftUI

struct SelectCityView: View {
    let onSelect: (String) -> Void
    @Environment(\.dismiss) private var dismiss
    private let cities = [
        "Москва",
        "Санкт Петербург",
        "Сочи",
        "Горный воздух",
        "Краснодар",
        "Казань",
        "Омск",
    ]
    
    var body: some View {
        SelectionListView(
            title: "Выбор города",
            searchPrompt: "Введите запрос",
            emptyMassage: "Город не найден",
            items: cities,
            onSelect: onSelect
        )
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundStyle(.ypBlack)
                }
            }
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
