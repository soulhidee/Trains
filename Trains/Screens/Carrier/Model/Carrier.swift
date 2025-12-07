import Foundation

struct Carrier: Identifiable, Sendable {
    let id = UUID()
    let carrier: CarrierInfo
    let departureTime: String
    let arrivalTime: String
    let duration: String
    let date: String
    let hasTransfers: Bool
    let transferInfo: String?
    let sortDate: Date
}
