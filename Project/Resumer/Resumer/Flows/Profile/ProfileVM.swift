import SwiftUI


final class ProfileVM: ObservableObject {
    
    @MainActor
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}
