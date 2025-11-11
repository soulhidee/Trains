

import SwiftUI

struct LocationTextField: View {
    let placeholder: String
    @Binding var text: String

    var body: some View {
        HStack(spacing: 12) {
            TextField(placeholder, text: $text)
                .foregroundStyle(.ypGray)
                .textInputAutocapitalization(.words)
        }
        
    }
}

#Preview {
    @Previewable @State var text = ""
    LocationTextField(placeholder: "Откуда", text: $text)
}
