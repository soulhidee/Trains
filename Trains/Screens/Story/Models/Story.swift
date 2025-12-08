import SwiftUI

struct Story: Identifiable, Sendable {
    
    // MARK: - Properties
    let id = UUID()
    let backgroundImageName: String
    let title: String
    let description: String
    
    // MARK: - Computed Property
    var backgroundImage: Image {
        Image(backgroundImageName)
    }
    
    // MARK: - Sample Stories
    static let story1 = Story(
        backgroundImageName: "story1",
        title: "Начало пути",
        description: "Утро на станции открывает новые возможности. Каждый день — это шанс отправиться в маленькое приключение."
    )

    static let story2 = Story(
        backgroundImageName: "story2",
        title: "В движении",
        description: "Поезда мчатся, а жизнь не стоит на месте. Каждый момент важен, каждая остановка — новая история."
    )

    static let story3 = Story(
        backgroundImageName: "story3",
        title: "Люди вокруг",
        description: "Толпа в вагоне напоминает, что у каждого свои цели, свои мечты и свои маленькие маршруты по жизни."
    )

    static let story4 = Story(
        backgroundImageName: "story4",
        title: "Тишина в пути",
        description: "Иногда пустой вагон и спокойное движение по рельсам дают возможность задуматься и перезагрузиться."
    )

    static let story5 = Story(
        backgroundImageName: "story5",
        title: "Ночная дорога",
        description: "Светящиеся вагоны скользят по заснеженным горам. Ночь, снег и путь создают особую атмосферу волшебства."
    )
}
