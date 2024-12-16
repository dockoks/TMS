import SwiftUI


final class RootVM: ObservableObject {
    @Published var showSignInView: Bool = true
    
    func checkAuthentication() {
        showSignInView = !AuthenticationManager.shared.isAuthenticated()
    }
}
