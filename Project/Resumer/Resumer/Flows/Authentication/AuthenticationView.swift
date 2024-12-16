import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth


struct AuthenticationView: View {
    @StateObject var viewModel: AuthenticationVM = .init()
    @Binding var showSignInView: Bool
    var body: some View {
        VStack {
            GoogleSignInButton(viewModel: .init(scheme: .light)) {
                Task {
                    do {
                        try await viewModel.signInGoogle()
                        showSignInView = false
                    } catch {
                        print(error)
                    }
                }
            }
            .buttonStyle(NoneButtonStyle())
            Spacer()
        }
        .navigationTitle("Sign In")
        .padding(16)
    }
}
