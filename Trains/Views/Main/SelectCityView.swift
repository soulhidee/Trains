

import SwiftUI

struct SelectCityView: View {
    let onSelect: (String) -> Void
    @State private var searchText = ""

    
    private let cities = [
        City(name: "Москва"),
        City(name: "Санкт Петербург"),
        City(name: "Сочи"),
        City(name: "Горный воздух"),
        City(name: "Краснодар"),
        City(name: "Казань"),
        City(name: "Омск"),
    ]
    
    
    var body: some View {
//        NavigationStack {
//            List(filterCities) { city in
//                RowCityView(city: city)
//                    .listRowSeparator(.hidden)
//            }
//            
//            .navigationTitle("Выбор города")
//            .navigationBarTitleDisplayMode(.inline)
//            .searchable(text: $searchText, prompt: "Введите запрос")
//            .overlay {
//                if filterCities.isEmpty && !searchText.isEmpty {
//                    Text("Город не найден")
//                        .font(.system(size: 24, weight: .bold))
//                }
//            }
//            
//        }
//        .environment(\.defaultMinListRowHeight, 60)
//        .listStyle(.plain)
        
    }
}

#Preview {
    SelectCityView { city in
        print("Выбран: \(city)")
    }
}
