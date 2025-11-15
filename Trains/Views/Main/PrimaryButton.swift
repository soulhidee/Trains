import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.ypWhiteUniversal)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(Color.ypBlue)
                .cornerRadius(16)
        }
    }
}

#Preview {
    PrimaryButton(title: "Найти", action: {
        print("Поиск нажат")
    })
    .padding()
}
