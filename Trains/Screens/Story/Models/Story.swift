import Foundation

import SwiftUI

struct Story: Identifiable {
    
    // MARK: - Properties
    let id = UUID()
    let backgroundImage: Image
    let title: String
    let description: String
    
    // MARK: - Sample Stories
    static let story1 = Story(
        backgroundImage: Image(.story1),
        title: "Начало пути",
        description: "Утро на станции открывает новые возможности. Каждый день — это шанс отправиться в маленькое приключение."
    )

    static let story2 = Story(
        backgroundImage: Image(.story2),
        title: "В движении",
        description: "Поезда мчатся, а жизнь не стоит на месте. Каждый момент важен, каждая остановка — новая история."
    )

    static let story3 = Story(
        backgroundImage: Image(.story3),
        title: "Люди вокруг",
        description: "Толпа в вагоне напоминает, что у каждого свои цели, свои мечты и свои маленькие маршруты по жизни."
    )

    static let story4 = Story(
        backgroundImage: Image(.story4),
        title: "Тишина в пути",
        description: "Иногда пустой вагон и спокойное движение по рельсам дают возможность задуматься и перезагрузиться."
    )

    static let story5 = Story(
        backgroundImage: Image(.story5),
        title: "Ночная дорога",
        description: "Светящиеся вагоны скользят по заснеженным горам. Ночь, снег и путь создают особую атмосферу волшебства."
    )
}
