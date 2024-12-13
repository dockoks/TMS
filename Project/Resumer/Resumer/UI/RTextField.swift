import SwiftUI
import Combine

struct RTextField: View {
    @Binding var text: String
    @Binding var isValid: Bool
    let symbolLimit: Int
    let placeholder: String
    let autoCorrection: Bool
    let keyboardType: UIKeyboardType
    
    @FocusState private var isFocused: Bool
    
    init(
        text: Binding<String>,
        isValid: Binding<Bool> = .constant(true),
        symbolLimit: Int,
        placeholder: String = "",
        autoCorrection: Bool = false,
        keyboardType: UIKeyboardType = .default
    ) {
        self._text = text
        self._isValid = isValid
        self.symbolLimit = symbolLimit
        self.placeholder = placeholder
        self.autoCorrection = autoCorrection
        self.keyboardType = keyboardType
    }
    
    var body: some View {
        TextField(placeholder, text: $text)
            .focused($isFocused)
            .onChange(of: text) { oldValue, newValue in
                if newValue.count < symbolLimit {
                    text = newValue
                }
            }
            .keyboardType(keyboardType)
            .tint(.black)
            .textFieldStyle(.plain)
            .autocorrectionDisabled(!autoCorrection)
            .typographyStyle(.body)
            .padding(.vertical, 4)
            .background(alignment: .bottomLeading) {
                Capsule()
                    .frame(width: !isFocused ? 0 : nil, height: 0.5)
                    .opacity(isFocused ? 1 : 0)
                    .foregroundStyle(isFocused ? ColorPalette.Outline.heavy : .clear)
                    .animation(.easeInOut(duration: 0.3), value: isFocused)
            }
            .frame(maxHeight: 36)
    }
}

#Preview {
    RTextField(
        text: .constant(""),
        isValid: .constant(true),
        symbolLimit: 30,
        placeholder: "Hello",
        keyboardType: .default
    )
}
