import Foundation

enum NavigationRoute: Hashable {
    case selectFromCity
    case selectToCity
    case selectFromStation(city: String)
    case selectToStation(city: String)
}
