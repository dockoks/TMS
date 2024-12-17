import SwiftUI


final class ProfileVM: ObservableObject {
    @Binding var showSignInView: Bool
    
    init(showSignInView: Binding<Bool>) {
        self._showSignInView = showSignInView
    }
    
    @MainActor
    func signOut() {
        Task {
            do {
                try AuthenticationManager.shared.signOut()
                showSignInView = true
            } catch {
                print(error)
            }
        }
    }
}
