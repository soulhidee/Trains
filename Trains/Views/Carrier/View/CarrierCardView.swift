import SwiftUI

struct CarrierCardView: View {
    let trip: Carrier
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 12) {
                        CarrierLogoView(logoURLString: trip.carrier.logo, title: trip.carrier.title)
                            .frame(width: 38, height: 38)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(.ypLightGray)
                            )
                        
                        Text(trip.carrier.title)
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.ypBlackUniversal)
                    }
                    
                    if let transferInfo = trip.transferInfo {
                        Text(transferInfo)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.ypRed)
                    }
                }
                
                Spacer()
                
                Text(trip.date)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.ypBlackUniversal)
            }
            
            .padding(.horizontal, 15)
            .padding(.top, 14)
            
            HStack {
                Text(trip.departureTime)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(Color(.ypBlackUniversal))
                
                HStack {
                    Rectangle()
                        .fill(.ypGray)
                        .frame(height: 1)
                    
                    Text(trip.duration)
                        .font(.system(size: 12))
                        .foregroundColor(.ypBlackUniversal)
                        .padding(.horizontal, 8)
                    
                    Rectangle()
                        .fill(.ypGray)
                        .frame(height: 1)
                }
                
                Text(trip.arrivalTime)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.ypBlackUniversal)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .background(.ypLightGray)
        .cornerRadius(24)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}


#Preview {
    CarrierCardView(trip: Carrier(
        carrier: CarrierInfo(
            title: "РЖД",
            logo: nil,
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
    .background(.ypWhite)
}
