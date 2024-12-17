import SwiftUI


struct ProfileView: View {
    @StateObject var viewModel: ProfileVM
    
    var body: some View {
        List {
            Button("Sign out") {
                viewModel.signOut()
            }
        }
        .navigationBarTitle("Profile")
    }
}
