//
//  IconButton.swift
//  Resumer
//
//  Created by Danila Kokin on 12/2/24.
//

import SwiftUI

enum RIcon: String {
    case chevronL = "chevron.left"
    case chevronR = "chevron.right"
    case star = "star.fill"
    case trash = "trash"
    case edit = "pencil"
    case minus = "minus"
    case link = "link"
    
    var image: Image {
        Image(systemName: self.rawValue)
    }
}

enum RIconButtonStyle {
    case primary
    case secondary
    case tertiary
}

enum RIconButtonSize {
    case L
    case M
}

struct RIconButton: View {
    @State var icon: RIcon
    let style: RIconButtonStyle
    @Binding var isEnabled: Bool
    let size: RIconButtonSize
    let action: () -> Void
    
    init(
        icon: RIcon,
        style: RIconButtonStyle = .primary,
        isEnabled: Binding<Bool> = .constant(true),
        size: RIconButtonSize = .L,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.style = style
        self.action = action
        self._isEnabled = isEnabled
        self.size = size
    }
    
    var body: some View {
        Button{
            if isEnabled {
                action()
            }
        } label: {
            icon.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(isEnabled ? fgColor : fgColorDisabled)
                .frame(width: iconSize, height: iconSize)
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .fill(isEnabled ? bgColor : bgColorDisabled)
                        .frame(width: buttonSize, height: buttonSize)
                )
        }
        .frame(width: buttonSize, height: buttonSize)
        .scaleEffectOnPressGesture()
        .buttonStyle(CustomButtonStyle())
        .disabled(!isEnabled)
    }
    
    private var bgColor: Color {
        return switch style {
        case .primary: .blue
        case .secondary: ColorPalette.Bg.layerThree
        case .tertiary: ColorPalette.Bg.layerTwo
        }
    }
    
    private var bgColorDisabled: Color {
        return switch style {
        case .primary: .blue.opacity(0.5)
        case .secondary: .gray.opacity(0.1)
        case .tertiary: .clear
        }
    }
    
    private var fgColor: Color {
        return switch style {
        case .primary: .white
        case .secondary: .black.opacity(0.5)
        case .tertiary: .black.opacity(0.3)
        }
    }
    
    private var fgColorDisabled: Color {
        return switch style {
        case .primary: .white
        case .secondary: .black.opacity(0.3)
        case .tertiary: .black.opacity(0.1)
        }
    }
    
    private var cornerRadius: CGFloat {
        switch size {
        case .L: return 16
        case .M: return 12
        }
    }
    
    private var buttonSize: CGFloat {
        switch size {
        case .L: return 48
        case .M: return 36
        }
    }
    
    private var iconSize: CGFloat {
        switch size {
        case .L: return 24
        case .M: return 20
        }
    }
}
