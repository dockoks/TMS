import SwiftUI


extension View {
    func scaleEffectOnPressGesture(scale: CGFloat = 0.98) -> some View {
        self.modifier(ScaleEffectGestureModifier(scale: scale))
    }
}

struct CustomButtonStyle: ButtonStyle {
    var pressedOpacity: Double = 0.5
    var normalOpacity: Double = 1.0
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? pressedOpacity : normalOpacity)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct ScaleEffectGestureModifier: ViewModifier {
    @State private var isPressed = false

    var scale: CGFloat

    func body(content: Content) -> some View {
        content
            .scaleEffect(isPressed ? scale : 1.0)
            .animation(.spring(response: 0.2, dampingFraction: 0.5), value: isPressed)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        isPressed = true
                    }
                    .onEnded { _ in
                        isPressed = false
                    }
            )
    }
}
