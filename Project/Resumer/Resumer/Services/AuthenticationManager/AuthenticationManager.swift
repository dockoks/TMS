import Foundation
import FirebaseAuth


final class AuthenticationManager {
    static let shared = AuthenticationManager()
    private init() {}
    
    @discardableResult
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
}

// MARK: - Google Sign In

extension AuthenticationManager {
    @discardableResult
    func signInWithGoogle(with tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel{
        let credential = GoogleAuthProvider.credential(
            withIDToken: tokens.idToken,
            accessToken: tokens.accessToken
        )
        return try await signIn(with: credential)
    }
    
    func signIn(with credential: AuthCredential) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
    }
}
