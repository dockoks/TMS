import SwiftUI


struct ProfileView: View {
    @StateObject private var vm = ProfileVM()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            Button("Sign out") {
                Task {
                    do {
                        try vm.signOut()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            }
        }
        .navigationBarTitle("Profile")
    }
}
