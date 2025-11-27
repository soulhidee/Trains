import SwiftUI

struct CarrierCardView: View {
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Constants
    private enum Constants {
        static let logoHeight: CGFloat = 104
        static let verticalPadding: CGFloat = 16
        static let horizontalPadding: CGFloat = 16
        static let contentTopPadding: CGFloat = 16
        
        static let companyName = "ОАО «РЖД»"
        static let email = "i.lozgkina@yandex.ru"
        static let phone = "+7 (904) 329-27-71"
        static let phoneLink = "tel:+79043292771"
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                logoView
                contentView
                Spacer()
            }
        }
        .navigationTitle("Информация о перевозчике")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                backButton
            }
        }
        .background(Color.ypWhite)
    }
    
    // MARK: - Subviews
    private var logoView: some View {
        Image(.rjdLogo)
            .resizable()
            .frame(maxWidth: .infinity, maxHeight: Constants.logoHeight)
            .padding(.vertical, Constants.verticalPadding)
            
    }
    
    private var contentView: some View {
        VStack(alignment: .leading, spacing: Constants.contentTopPadding) {
            companyNameText
            contactListView
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, Constants.horizontalPadding)
    }
    
    private var companyNameText: some View {
        Text(Constants.companyName)
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.ypBlack)
    }
    
    private var contactListView: some View {
        List {
            ContactRowView(
                title: "E-mail",
                value: Constants.email,
                url: URL(string: "mailto:\(Constants.email)")
            )
            
            ContactRowView(
                title: "Телефон",
                value: Constants.phone,
                url: URL(string: Constants.phoneLink)
            )
        }
        .listStyle(.plain)
        .scrollDisabled(true)
        .frame(height: 140)
    }
    
    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(.ypBlack)
        }
    }
}

#Preview {
    NavigationStack {
        CarrierCardView()
    }
}
