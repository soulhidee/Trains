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
}

extension CarrierModel {
    static let schedule: [CarrierModel] = [
        CarrierModel(
            logoName: "RJD",
            name: "РЖД",
            transferInfo: "С пересадкой в Костроме",
            departure: "22:30",
            arrival: "08:15",
            duration: "20 часов",
            date: "14 января"
        ),
        CarrierModel(
            logoName: "FGK",
            name: "ФГК",
            transferInfo: "",
            departure: "01:15",
            arrival: "09:00",
            duration: "19 часов",
            date: "15 января"
        ),
        CarrierModel(
            logoName: "URAL",
            name: "Урал логистика",
            transferInfo: "",
            departure: "12:30",
            arrival: "21:00",
            duration: "9 часов",
            date: "16 января"
        ),
        CarrierModel(
            logoName: "RJD",
            name: "РЖД",
            transferInfo: "С пересадкой в Костроме",
            departure: "22:30",
            arrival: "08:15",
            duration: "20 часов",
            date: "17 января"
        ),
        CarrierModel(
            logoName: "RJD",
            name: "РЖД",
            transferInfo: "С пересадкой в Костроме",
            departure: "00:00",
            arrival: "09:00",
            duration: "9 часов",
            date: "17 января"
        )
    ]
}
