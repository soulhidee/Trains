import Foundation

enum Filter {
    static let departureTime = "Время отправления"
    static let showTransfers = "Показывать варианты с пересадками"
    static let yes = "Да"
    static let no = "Нет"
    
    enum DepartureTime {
        static let morning = "Утро 06:00 - 12:00"
        static let afternoon = "День 12:00 - 18:00"
        static let evening = "Вечер 18:00 - 00:00"
        static let night = "Ночь 00:00 - 06:00"
    }
}
