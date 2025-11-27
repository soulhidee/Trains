//
//  CarrierLogoView.swift
//  Trains
//
//  Created by Даниил on 17.11.2025.
//

import SwiftUI

struct CarrierLogoView: View {
    let logoName: String
    let name: String
    let transferInfo: String?
    
    var body: some View {
        HStack(spacing: 8) {
            logoImage
            carrierInfo
        }
    }
    
    private  var logoImage: some View {
        Image(logoName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 38, height: 38)
            .cornerRadius(12)
    }
    
    private var carrierInfo: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(name)
                .font(.system(size: 17, weight: .regular))
                .kerning(-0.41)
                .foregroundColor(Color(.ypBlackUniversal))
            
            if let transferInfo {
                Text(transferInfo)
                    .font(.system(size: 12, weight: .regular))
                    .kerning(0.4)
                    .foregroundColor(.ypRed)
            }
        }
        
    }
}

#Preview {
    CarrierLogoView(
        logoName: "RJD",
        name: "РЖД",
        transferInfo: "С пересадкой в Кастроме"
    )
}
