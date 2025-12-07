import SwiftUI

struct SettingsRowView: View {
    // MARK: - Properties
    let title: String
    let showToggle: Bool
    let showChevron: Bool
    let action: (() -> Void)?
    
    @Binding var isOn: Bool
    
    // MARK: - Init
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
    
    // MARK: - Body
    var body: some View {
        Button(action: {
            action?()
        }) {
            HStack {
                // MARK: - Title
                Text(title)
                    .foregroundStyle(.ypBlack)
                    .font(.system(size: 17))
                
                Spacer()
                
                // MARK: - Trailing Accessory
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

// MARK: - Preview
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
