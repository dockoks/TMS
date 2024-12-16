import SwiftUI
import GoogleSignIn
import FirebaseAuth
import GoogleSignInSwift


@MainActor
final class AuthenticationVM: ObservableObject {
    func signInGoogle() async throws {
        guard let topVC = Utilities.shared.topViewController() else {
            throw URLError(.badURL)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken: String = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badURL)
        }
        
        let accessToken: String = gidSignInResult.user.accessToken.tokenString
        
        let tokens = GoogleSignInResultModel(
            idToken: idToken,
            accessToken: accessToken
        )
        
        try await AuthenticationManager.shared.signInWithGoogle(with: tokens)
    }
}
