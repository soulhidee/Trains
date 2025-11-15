import Foundation

enum SelectionDestination: Hashable {
    case station(cityName: String, isFrom: Bool)
}
