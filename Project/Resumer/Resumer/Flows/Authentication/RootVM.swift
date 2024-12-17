import SwiftUI


final class RootVM: ObservableObject {
    @Published var showSignInView: Bool = true
    @Published var authData: AuthDataResultModel = AuthDataResultModel()
    
    func checkAuthentication() {
        do {
            let user = try AuthenticationManager.shared.getAuthenticatedUser()
            authData = user
            showSignInView = false
        } catch {
            showSignInView = true
            print("Error checking authentication: \(error.localizedDescription)")
        }
    }
}
