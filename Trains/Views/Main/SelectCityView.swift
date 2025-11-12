

import SwiftUI

struct SelectCityView: View {
    let onSelect: (String) -> Void

    
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
        NavigationStack {
            List(cities) { city in
                RowCityView(city: city)
                    .listRowSeparator(.hidden)
            }
            
            .navigationTitle("Выбор города")
            .navigationBarTitleDisplayMode(.inline)
        }
        .environment(\.defaultMinListRowHeight, 60)
        .listStyle(.plain)
        
    }
}

#Preview {
    SelectCityView { city in
    print("Выбран: \(city)")
    }
}
