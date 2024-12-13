import SwiftUI

enum RButtonStyle {
    case primary
    case secondary
    case tretiary
}

struct RButton: View {
    let icon: RIcon?
    let style: RButtonStyle
    let title: String
    
    @Binding var isEnabled: Bool
    let cornerRadius: CGFloat
    let action: () -> Void
    
    init(
        icon: RIcon? = nil,
        style: RButtonStyle = .primary,
        title: String,
        isEnabled: Binding<Bool> = .constant(true),
        cornerRadius: CGFloat = 16,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.style = style
        self.title = title
        self.action = action
        self._isEnabled = isEnabled
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        Button(action: {
            if isEnabled {
                action()
            }
        }) {
            ZStack {
                ContinuousCornerShape(cornerRadius: cornerRadius)
                    .fill(isEnabled ? bgColor : bgColorDisabled)
                HStack {
                    if let icon = icon {
                        icon.image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(isEnabled ? fgColor : fgColorDisabled)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(12)
                    }
                    Text(title)
                        .typographyStyle(.body)
                        .foregroundStyle(isEnabled ? fgColor : fgColorDisabled)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 48)
        }
        .scaleEffectOnPressGesture()
        .buttonStyle(CustomButtonStyle())
        .disabled(!isEnabled)
    }
    
    private var bgColor: Color {
        return switch style {
        case .primary: .blue
        case .secondary: .gray.opacity(0.5)
        case .tretiary: .clear
        }
    }
    
    private var bgColorDisabled: Color {
        return switch style {
        case .primary: .blue.opacity(0.5)
        case .secondary: .gray.opacity(0.1)
        case .tretiary: .clear
        }
    }
    
    private var fgColor: Color {
        return switch style {
        case .primary: .white
        case .secondary: .black.opacity(0.5)
        case .tretiary: .black.opacity(0.3)
        }
    }
    
    private var fgColorDisabled: Color {
        return switch style {
        case .primary: .white
        case .secondary: .black.opacity(0.3)
        case .tretiary: .black.opacity(0.1)
        }
    }
}

#Preview {
    RButton(title: "Hello") {}
}
