import SwiftUI

struct SelectCityView: View {
    let onSelect: (String) -> Void
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
        
    }
}

#Preview {
    SelectCityView { city in
        print("Выбран: \(city)")
    }
}
