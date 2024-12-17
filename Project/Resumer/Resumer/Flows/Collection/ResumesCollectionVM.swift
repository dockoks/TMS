import SwiftUI


class ResumesCollectionVM: ObservableObject {
    @Binding var showSignInView: Bool
    @Published var collection: [ResumeCreationVM] = []
    let userID: String
    
    init(
        userID: String,
        showSignInView: Binding<Bool>,
        collection: [ResumeCreationVM] = []
    ) {
        self.userID = userID
        self._showSignInView = showSignInView
        self.collection = collection
        
        // TODO: - Delete after testing
//        self.collection.append(ResumeCreationVM.mock(userID: userID))
    }
    
    func fetchUserResumes() {
//        FirebaseStorageManager.shared.
    }
}
