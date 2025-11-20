//
//  ScheduleCardView.swift
//  Trains
//
//  Created by Даниил on 17.11.2025.
//

import SwiftUI

struct ScheduleCardView: View {
    let schedule: CarrierModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            carrierInfoSection
            timeSection
        }
        .padding(14)
        .background(Color(.ypLightGray))
        .cornerRadius(24)
  

    }

    private var carrierInfoSection: some View {
        HStack {
            CarrierLogoView(logoName: schedule.logoName,
                            name: schedule.name,
                            transferInfo: schedule.transferInfo
            )
            Spacer()
            Text(schedule.date)
                .font(.system(size: 12, weight: .regular))
                .kerning(0.4)
                .foregroundColor(Color.ypBlackUniversal)
                .padding(.top, -15)
                .padding(.trailing, -7)
        }
    }
    
    private var timeSection: some View {
        HStack(alignment: .center) {
            departureTimeView
            Spacer().frame(width: 4)
            durationView
            Spacer().frame(width: 4)
            arrivalTimeView
        }
    }
    
    private var departureTimeView: some View {
        Text(schedule.departure)
            .font(.system(size: 17, weight: .regular))
            .kerning(-0.41)
            .foregroundColor(Color.ypBlackUniversal)
            .frame(width: 46, alignment: .leading)
    }
    
    private var durationView: some View {
        HStack(spacing: 4) {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.ypGray)
            Text(schedule.duration)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.black)
                .fixedSize()
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.ypGray)
        }
    }
    
    private var arrivalTimeView: some View {
        Text(schedule.arrival)
            .font(.system(size: 17, weight: .regular))
            .kerning(-0.41)
            .foregroundColor(Color.ypBlackUniversal)
            .frame(width: 46, alignment: .trailing)
    }
}

#Preview {
    ScheduleCardView(
        schedule: CarrierModel(
            logoName: "rjd",
            name: "РЖД",
            transferInfo: "С пересадкой в Костроме",
            departure: "22:30",
            arrival: "08:15",
            duration: "20 часов",
            date: "14 января"
        )
    )
}
