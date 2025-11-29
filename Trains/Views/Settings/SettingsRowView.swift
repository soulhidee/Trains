import SwiftUI

struct SettingsRowView: View {
    let title: String
    let showToggle: Bool
    let showChevron: Bool
    @Binding var isOn: Bool
    let action: (() -> Void)?
    
    init(
        title: String,
        showToggle: Bool = false,
        showChevron: Bool = false,
        isOn: Binding<Bool> = .constant(false),
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.showToggle = showToggle
        self.showChevron = showChevron
        self._isOn = isOn
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            action?()
        }) {
            HStack {
                Text(title)
                    .foregroundStyle(.ypBlack)
                    .font(.system(size: 17))
                
                Spacer()
                
                if showToggle {
                    Toggle("", isOn: $isOn)
                        .labelsHidden()
                } else if showChevron {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.ypBlack)
                        .font(.system(size: 24))
                }
            }
        }
        .listRowBackground(Color.ypWhite)
    }
}

#Preview {
    VStack(spacing: 0) {
        SettingsRowView(
            title: "Темная тема",
            showToggle: true,
            isOn: .constant(false)
        )
        
        SettingsRowView(
            title: "Пользовательское соглашение",
            showChevron: true,
            action: {
                print("Открыть соглашение")
            }
        )
    }
    .background(Color.ypWhite)
}
