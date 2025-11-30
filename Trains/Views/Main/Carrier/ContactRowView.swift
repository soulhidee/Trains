import SwiftUI

struct ContactRowView: View {
    let title: String
    let value: String
    let url: URL?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(title)
                    .font(.system(size: 17))
                    .foregroundColor(.ypBlack)
                
                if let url = url {
                    Link(value, destination: url)
                        .font(.system(size: 12))
                        .foregroundColor(.ypBlue)
                } else {
                    Text(value)
                        .font(.system(size: 12))
                        .foregroundColor(.ypBlue)
                }
            }
            Spacer()
        }
        .padding(.vertical, 12)
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
        .background(.ypWhite)
    }
}

#Preview {
    List {
        ContactRowView(
            title: "E-mail",
            value: "i.lozgkina@yandex.ru",
            url: URL(string: "mailto:i.lozgkina@yandex.ru")
        )
        ContactRowView(
            title: "Телефон",
            value: "+7 (904) 329-27-71",
            url: URL(string: "tel:+79043292771")
        )
    }
}
