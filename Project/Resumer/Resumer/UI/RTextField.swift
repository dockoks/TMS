import SwiftUI
import Combine

struct RTextField: View {
    @Binding var text: String
    var isValid: Bool
    let symbolLimit: Int
    let placeholder: String
    let autoCorrection: Bool
    let keyboardType: UIKeyboardType
    
    @FocusState private var isFocused: Bool
    
    init(
        text: Binding<String>,
        isValid: Bool = true,
        symbolLimit: Int,
        placeholder: String = "",
        autoCorrection: Bool = false,
        keyboardType: UIKeyboardType = .default
    ) {
        self._text = text
        self.isValid = isValid
        self.symbolLimit = symbolLimit
        self.placeholder = placeholder
        self.autoCorrection = autoCorrection
        self.keyboardType = keyboardType
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TextField(placeholder, text: $text)
                .focused($isFocused)
                .onReceive(Just(text)) { newValue in
                    if newValue.count > symbolLimit {
                        text = String(newValue.prefix(symbolLimit))
                    }
                }
                .keyboardType(keyboardType)
                .tint(.black)
                .textFieldStyle(.plain)
                .autocorrectionDisabled(!autoCorrection)
                .foregroundColor(isFocused ? (isValid ? .black : .red) : .black)
                .typographyStyle(.body)
                .padding(.vertical, 4)
            Capsule()
                .frame(height: 2)
                .frame(maxWidth: isFocused ? .infinity : 0)
                .foregroundStyle(isFocused ? (isValid ? Color.black.opacity(0.16) : .red) : Color.clear)
                .animation(.easeInOut(duration: 0.3), value: isFocused)
        }
        .frame(maxHeight: 36)
        .overlay(alignment: .topLeading) {
            if isFocused {
                Text(placeholder)
                    .typographyStyle(.caption)
                    .foregroundStyle(ColorPalette.Text.tertiary)
            }
        }
    }
}

#Preview {
    RTextField(
        text: .constant(""),
        isValid: true,
        symbolLimit: 30,
        placeholder: "Hello",
        keyboardType: .default
    )
}
