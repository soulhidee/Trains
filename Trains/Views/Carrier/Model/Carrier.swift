import Foundation

struct CarrierModel: Identifiable {
    let id = UUID()
    let logoName: String
    let name: String
    let transferInfo: String?
    let departure: String
    let arrival: String
    let duration: String
    let date: String
    let sortDate: Date
    let carrierCode: Int?
    let hasTransfers: Bool
    
    init(
        logoName: String,
        name: String,
        transferInfo: String?,
        departure: String,
        arrival: String,
        duration: String,
        date: String,
        sortDate: Date = Date(),
        carrierCode: Int? = nil,
        hasTransfers: Bool = false
    ) {
        self.logoName = logoName
        self.name = name
        self.transferInfo = transferInfo
        self.departure = departure
        self.arrival = arrival
        self.duration = duration
        self.date = date
        self.sortDate = sortDate
        self.carrierCode = carrierCode
        self.hasTransfers = hasTransfers
    }
}
