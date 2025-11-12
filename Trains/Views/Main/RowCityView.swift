import SwiftUI

struct RowCityView: View {
    let city: City
    var body: some View {
        HStack {
            Text(city.name)
                .font(.system(size: 17, weight: .regular))
                .foregroundStyle(.ypBlack)
            Spacer()
            Image(.arrow)
                .foregroundStyle(.ypBlack)
        }
    }
}

#Preview {
    RowCityView(city: City(name: "Москва"))
}
