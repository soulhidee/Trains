import SwiftUI

struct SettingsInfoView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Приложение использует API «Яндекс.Расписания»")
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.ypBlack)
            Text("Версия 1.0 (beta)")
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.ypBlack)
        }
        .background(Color.ypWhite)
    }
}

#Preview {
    SettingsInfoView()
}
