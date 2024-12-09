import SwiftUI
import Combine

class KeyboardResponder: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    private var cancellable: AnyCancellable?

    init() {
        cancellable = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .merge(with: NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification))
            .compactMap { notification -> CGFloat? in
                if let endFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    return notification.name == UIResponder.keyboardWillHideNotification ? 0 : endFrame.height
                }
                return nil
            }
            .assign(to: \.keyboardHeight, on: self)
    }
}
