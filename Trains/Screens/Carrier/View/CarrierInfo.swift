import SwiftUI
import OpenAPIURLSession

// MARK: - CarrierInfoView
struct CarrierInfoView: View {
    // MARK: - Properties
    let carrier: CarrierInfo
    let onBack: () -> Void
    
    @State private var email: String? = nil
    @State private var phone: String? = nil
    @State private var detailsLoaded = false
    
    private let apikey = Secrets.apiKey
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            headerSection
            contentSection
        }
        .background(.ypWhite)
        .navigationBarHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .onAppear { parseInitialContacts() }
        .task(id: carrier.code) { await loadCarrierDetails() }
    }
    
    // MARK: - Subviews
    private var headerSection: some View {
        VStack(spacing: 0) {
            Color.ypWhite.frame(height: 12).ignoresSafeArea(edges: .top)
            
            ZStack {
                Text("Информация о перевозчике")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.ypBlack)
                    .multilineTextAlignment(.center)
                
                HStack {
                    Button(action: onBack) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.ypBlack)
                    }
                    .padding(.leading, 16)
                    Spacer()
                }
            }
            .padding(.vertical, 12)
            .padding(.top, 8)
            .padding(.bottom, 16)
        }
        .background(.ypWhite)
    }
    
    private var contentSection: some View {
        ScrollView {
            VStack(spacing: 24) {
                logoSection
                titleSection
                emailSection
                phoneSection
                Spacer(minLength: 0)
            }
            .padding(.top, 8)
        }
    }
    
    private var logoSection: some View {
        CarrierInfoLogoView(logoURLString: carrier.logo, title: carrier.title)
            .frame(height: 104)
            .padding(.horizontal, 16)
    }
    
    private var titleSection: some View {
        Text(carrier.title)
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.ypBlack)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
    }
    
    private var emailSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("E-mail")
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.ypBlack)
            if let email = email, let url = URL(string: "mailto:\(email)") {
                Link(email, destination: url)
                    .font(.system(size: 15))
                    .foregroundColor(.ypBlue)
            } else {
                Text("—")
                    .font(.system(size: 15))
                    .foregroundColor(.ypGray)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
    }
    
    private var phoneSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Телефон")
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.ypBlack)
            if let phone = phone {
                let tel = phone.filter { !$0.isWhitespace }
                if let url = URL(string: "tel:\(tel)") {
                    Link(phone, destination: url)
                        .font(.system(size: 15))
                        .foregroundColor(.ypBlue)
                } else {
                    Text(phone)
                        .font(.system(size: 15))
                        .foregroundColor(.ypGray)
                }
            } else {
                Text("—")
                    .font(.system(size: 15))
                    .foregroundColor(.ypGray)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
    }
    
    // MARK: - Private Methods
    private func parseInitialContacts() {
        guard email == nil, (carrier.email != nil || carrier.contacts != nil) else { return }
        let parsed = parseContacts(carrier.contacts)
        email = carrier.email ?? parsed.email
        phone = carrier.phone ?? parsed.phone
    }
    
    private func loadCarrierDetails() async {
        guard !detailsLoaded, let code = carrier.code else { return }
        detailsLoaded = true
        do {
            let client = Client(serverURL: URL(string: "https://api.rasp.yandex.net")!, transport: URLSessionTransport())
            let service = CarrierService(client: client)
            let response = try await service.getCarrierInfo(
                apikey: apikey,
                code: String(code),
                system: nil,
                lang: "ru_RU",
                format: "json"
            )
            if let carrier = response.carriers?.first {
                let parsed = parseContacts(carrier.contacts)
                let emailValue = carrier.email ?? parsed.email
                let phoneValue = carrier.phone ?? parsed.phone
                await MainActor.run {
                    email = emailValue
                    phone = phoneValue
                }
            }
        } catch {}
    }
    
    private func parseContacts(_ contacts: String?) -> (email: String?, phone: String?) {
        guard let contacts, !contacts.isEmpty else { return (nil, nil) }
        var emailFound: String? = nil
        var phoneFound: String? = nil
        let lines = contacts.components(separatedBy: CharacterSet.newlines)
        for line in lines {
            let trimmed = line.trimmingCharacters(in: .whitespacesAndNewlines)
            if emailFound == nil, let range = trimmed.range(of: "[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}", options: [.regularExpression, .caseInsensitive]) {
                emailFound = String(trimmed[range])
            }
            if phoneFound == nil, let range = trimmed.range(of: "[+]?\\d[\\d ()-]{6,}\\d", options: .regularExpression) {
                phoneFound = String(trimmed[range])
            }
        }
        return (emailFound, phoneFound)
    }
}

// MARK: - CarrierInfoLogoView
struct CarrierInfoLogoView: View {
    let logoURLString: String?
    let title: String
    
    var body: some View {
        Group {
            if let urlString = logoURLString?.replacingOccurrences(of: "http://", with: "https://"),
               let url = URL(string: urlString) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty: placeholder
                    case .success(let image): image.resizable().scaledToFit()
                    case .failure: monogram
                    @unknown default: placeholder
                    }
                }
            } else {
                monogram
            }
        }
    }
    
    private var placeholder: some View { Color(.ypLightGray) }
    
    private var monogram: some View {
        ZStack {
            Color(.ypWhite)
            Text(initials(from: title))
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.ypWhite)
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    private func initials(from title: String) -> String {
        let parts = title.split(separator: " ")
        let first = parts.first?.first.map { String($0) } ?? ""
        let second = parts.dropFirst().first?.first.map { String($0) } ?? ""
        return (first + second).uppercased()
    }
}

// MARK: - Preview
#Preview {
    CarrierInfoView(
        carrier: CarrierInfo(title: "ОАО «РЖД»", logo: nil, code: 1, email: nil, phone: nil, url: nil, contacts: nil),
        onBack: {}
    )
}
