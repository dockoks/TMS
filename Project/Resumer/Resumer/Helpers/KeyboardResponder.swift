import SwiftUI
import Combine


final class KeyboardResponder: ObservableObject {
    @Published var isKeyboardVisible: Bool = false
    @Published var keyboardHeight: CGFloat = 0
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        let keyboardWillShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
        let keyboardWillHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
        
        keyboardWillShow
            .merge(with: keyboardWillHide)
            .sink { [weak self] notification in
                self?.handleKeyboardNotification(notification)
            }
            .store(in: &cancellables)
    }
    
    private func handleKeyboardNotification(_ notification: Notification) {
        if notification.name == UIResponder.keyboardWillShowNotification {
            isKeyboardVisible = true
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                keyboardHeight = keyboardFrame.height
            }
        } else if notification.name == UIResponder.keyboardWillHideNotification {
            isKeyboardVisible = false
            keyboardHeight = 0
        }
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
}
