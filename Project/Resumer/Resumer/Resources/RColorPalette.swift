import SwiftUI

enum ColorPalette{
    enum Bg {
        static let layerOne: Color = Color("layer1")
        static let layerTwo: Color = Color("layer2")
        static let layerThree: Color = Color("layer3")
        static let accent: Color = Color("accent")
    }
    
    enum Text {
        static let primary: Color = Color("primary")
        static let secondary: Color = Color("secondary")
        static let tertiary: Color = Color("tertiary")
    }
    
    enum Outline {
        static let heavy: Color = Color("heavy")
        static let light: Color = Color("light")
    }
    
    enum Main {
        static let blue: Color = Color("blue")
    }
}
