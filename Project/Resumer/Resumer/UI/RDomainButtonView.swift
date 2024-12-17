import SwiftUI


struct RDomainButtonView: View {
    @Binding var domain: LinkDomain
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            icon
                .resizable()
                .aspectRatio(contentMode: .fit)
                .tint(Color.primary.opacity(0.5))
                .padding(6)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(ColorPalette.Bg.layerOne)
                )
                .frame(width: 36, height: 36)
        }
    }
    
    var icon: Image {
        return switch domain {
        case .linkedIn: Image(systemName: "link")
        default: Image(systemName: "questionmark.circle.dashed")
        }
    }
}
