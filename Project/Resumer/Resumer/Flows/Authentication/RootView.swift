import SwiftUI


struct RootView: View {
    @StateObject private var viewModel = RootVM()
    
    var body: some View {
        ZStack {
            NavigationStack {
                ResumesCollection(
                    viewModel: .init(
                        userID: viewModel.authData.uid,
                        showSignInView: $viewModel.showSignInView
                    )
                )
            }
        }
        .onAppear() {
            viewModel.checkAuthentication()
        }
        .fullScreenCover(isPresented: $viewModel.showSignInView) {
            NavigationStack {
                AuthenticationView(showSignInView: $viewModel.showSignInView)
            }
        }
    }
}
