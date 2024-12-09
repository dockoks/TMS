import SwiftUI

// MARK: - Font Extension for Manrope
extension Font {
    enum ManropeFont: String {
        case extraBold = "Manrope-ExtraBold"
        case semiBold = "Manrope-SemiBold"
        case bold = "Manrope-Bold"
        case medium = "Manrope-Medium"
        case regular = "Manrope-Regular"
        case light = "Manrope-Light"
    }

    static func custom(_ customFont: ManropeFont, size: CGFloat) -> Font {
        let fontName = customFont.rawValue
        let descriptor = UIFontDescriptor(name: fontName, size: size)
        return Font(UIFont(descriptor: descriptor, size: size))
    }

    // Define typography styles
    enum TypographyStyle {
        case body
        case title
        case caption
        case headline
        case subheadline
        case footnote
    }
}

// MARK: - Typography Modifier
extension View {
    func typographyStyle(_ style: Font.TypographyStyle) -> some View {
        modifier(TypographyModifier(style: style))
    }
}

struct TypographyModifier: ViewModifier {
    let style: Font.TypographyStyle

    func body(content: Content) -> some View {
        content
            .font(fontForStyle(style))
    }

    private func fontForStyle(_ style: Font.TypographyStyle) -> Font {
        switch style {
        case .body:
            return Font.custom(.medium, size: 16)
        case .title:
            return Font.custom(.bold, size: 24)
        case .caption:
            return Font.custom(.semiBold, size: 12)
        case .headline:
            return Font.custom(.semiBold, size: 20)
        case .subheadline:
            return Font.custom(.semiBold, size: 14)
        case .footnote:
            return Font.custom(.regular, size: 16)
        }
    }

    private func lineSpacingForStyle(_ style: Font.TypographyStyle) -> CGFloat {
        switch style {
        case .body: return 5
        case .title: return 8
        case .caption: return 3
        case .headline: return 6
        case .subheadline: return 4
        case .footnote: return 2
        }
    }
}

// MARK: - Example Usage

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Title")
                .typographyStyle(.title)

            Text("Headline")
                .typographyStyle(.headline)

            Text("Body text goes here")
                .typographyStyle(.body)

            Text("Caption text")
                .typographyStyle(.caption)

            Text("Footnote")
                .typographyStyle(.footnote)
        }
        .padding()
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
