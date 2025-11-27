import SwiftUI

struct CarrierCardView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Image(.rjdLogo)
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 104)
                    .padding(.top, 16)

                VStack(alignment: .leading, spacing: 24) {
                    Text("ОАО «РЖД»")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.ypBlack)

                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("E-mail")
                            .font(.system(size: 17))
                            .foregroundColor(.ypBlack)
                        
                        Link("i.lozgkina@yandex.ru", destination: URL(string: "mailto:i.lozgkina@yandex.ru")!)
                            .font(.system(size: 12))
                            .foregroundColor(.ypBlue)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Телефон")
                            .font(.system(size: 17))
                            .foregroundColor(.ypBlack)
                        
                        Link("+7 (904) 329-27-71", destination: URL(string: "tel:+79043292771")!)
                            .font(.system(size: 12))
                            .foregroundColor(.ypBlue)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.top, 32)
                
                Spacer()
            }
        }
        .navigationTitle("Информация о перевозчике")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.ypBlack)
                }
            }
        }
        .background(Color.ypWhite)
    }
}

#Preview {
    NavigationStack {
        CarrierCardView()
    }
}
