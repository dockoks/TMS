import Foundation
import FirebaseAuth


final class AuthenticationManager {
    static let shared = AuthenticationManager()
    private init() {}
    
    func isAuthenticated() -> Bool {
        do {
            try getAuthenticatedUser()
            return true
        } catch {
            return false
        }
    }
    
    @discardableResult
    func getAuthenticatedUser() throws -> AuthDataresultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return AuthDataresultModel(user: user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
}

// MARK: - Google Sign In

extension AuthenticationManager {
    @discardableResult
    func signInWithGoogle(with tokens: GoogleSignInResultModel) async throws -> AuthDataresultModel{
        let credential = GoogleAuthProvider.credential(
            withIDToken: tokens.idToken,
            accessToken: tokens.accessToken
        )
        return try await signIn(with: credential)
    }
    
    func signIn(with credential: AuthCredential) async throws -> AuthDataresultModel{
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataresultModel(user: authDataResult.user)
    }
}
