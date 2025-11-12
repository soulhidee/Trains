import Foundation

struct City: Hashable, Identifiable {
    var id = UUID()
    var name: String
}
