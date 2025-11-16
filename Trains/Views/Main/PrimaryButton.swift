import SwiftUI

struct PrimaryButton: View {
    let title: String
    let showIndicator: Bool
    let action: () -> Void
    
    init(title: String, showIndicator: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.showIndicator = showIndicator
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.ypWhiteUniversal)
                
                if showIndicator {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 8, height: 8)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(Color.ypBlue)
            .cornerRadius(16)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        PrimaryButton(title: "Найти", action: {
            print("Поиск нажат")
        })
        
        PrimaryButton(title: "Уточнить время", showIndicator: true, action: {
            print("Фильтр нажат")
        })
    }
    .padding()
}
