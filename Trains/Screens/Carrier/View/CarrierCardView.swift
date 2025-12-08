import SwiftUI

// MARK: - CarrierCardView
struct CarrierCardView: View {
    // MARK: - Properties
    let carrierData: Carrier
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 4) {
            headerSection
            timeSection
        }
        .background(.ypLightGray)
        .cornerRadius(24)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    
    // MARK: - Subviews
    private var headerSection: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 12) {
                    CarrierLogoView(logoURLString: carrierData.carrier.logo, title: carrierData.carrier.title)
                        .frame(width: 38, height: 38)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.ypLightGray)
                        )
                    VStack(alignment: .leading, spacing: 2) {
                        Text(carrierData.carrier.title)
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.ypBlackUniversal)
                        
                        if let transferInfo = carrierData.transferInfo {
                            Text(transferInfo)
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(.ypRed)
                        }
                    }
                }
            }
            
            Spacer()
            
            Text(carrierData.date)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.ypBlackUniversal)
        }
        .padding(.horizontal, 14)
        .padding(.top, 14)
    }
    
    private var timeSection: some View {
        HStack {
            Text(carrierData.departureTime)
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(.ypBlackUniversal)
            
            HStack {
                Rectangle()
                    .fill(.ypGray)
                    .frame(height: 1)
                
                Text(carrierData.duration)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.ypBlackUniversal)
                    .padding(.horizontal, 5)
                
                Rectangle()
                    .fill(.ypGray)
                    .frame(height: 1)
            }
            
            Text(carrierData.arrivalTime)
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(.ypBlackUniversal)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 14)
    }
}

// MARK: - Preview
#Preview {
    CarrierCardView(carrierData: Carrier(
        carrier: CarrierInfo(
            title: "РЖД",
            logo: "https://yastat.net/s3/rasp/media/data/company/logo/logo.gif",
            code: 1,
            email: nil,
            phone: nil,
            url: nil,
            contacts: nil
        ),
        departureTime: "22:30",
        arrivalTime: "08:15",
        duration: "20 часов",
        date: "14 января",
        hasTransfers: true,
        transferInfo: "С пересадкой в Костроме",
        sortDate: Date()
    ))
    .padding()
}
