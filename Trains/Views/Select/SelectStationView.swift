//
//  SelectStationView.swift
//  Trains
//
//  Created by Даниил on 12.11.2025.
//

import SwiftUI

struct SelectStationView: View {
    let cityName: String
    let onSelect: (String) -> Void
    @Environment(\.dismiss) private var dismiss
    
    private var stations: [String] {
        if cityName == "Москва" {
            return [
                "Киевский вокзал",
                "Курский вокзал",
                "Ярославский вокзал",
                "Белорусский вокзал",
                "Савеловский вокзал",
                "Ленинградский вокзал"
            ]
        } else if cityName == "Санкт Петербург" {
            return [
                "Московский вокзал",
                "Витебский вокзал",
                "Финляндский вокзал",
                "Балтийский вокзал",
            ]
        } else {
            return ["\(cityName) вокзал"]
        }
    }
    
    var body: some View {
        SelectionListView(title: "Выбор станции",
                          searchPrompt: "Введите запрос",
                          emptyMassage: "Станция не найдена",
                          items: stations,
                          onSelect: onSelect)
    }
}

#Preview {
    NavigationStack {
        SelectStationView(cityName: "Москва") { station in
            print("Выбрана: \(station)")
        }
    }
}
