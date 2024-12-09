//
//  IconButton.swift
//  Resumer
//
//  Created by Danila Kokin on 12/2/24.
//

import SwiftUI

enum RIcon: String {
    case chevron = "chevron.right"
    case star = "star.fill"
    case trash = "trash"
    case edit = "pencil"

    var image: Image {
        Image(systemName: self.rawValue)
    }
}

enum RIconButtonStyle {
    case primary
    case secondary
    case tretiary
}

struct RIconButton: View {
    let icon: RIcon
    let style: RIconButtonStyle
    
    @Binding var isEnabled: Bool
    let cornerRadius: CGFloat
    let action: () -> Void

    init(
        icon: RIcon = .chevron,
        style: RIconButtonStyle = .primary,
        isEnabled: Binding<Bool> = .constant(true),
        cornerRadius: CGFloat = 16,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.style = style
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
                icon.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(isEnabled ? fgColor : fgColorDisabled)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(12)
            }
            .frame(width: 48, height: 48)
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
    RIconButton() {}
}
