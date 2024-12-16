import SwiftUI


class ResumesCollectionVM: ObservableObject {
    let userID = UUID()
    @Published var collection: [ResumeCreationVM] = []
    
    init(collection: [ResumeCreationVM] = []) {
        self.collection = collection
        self.collection.append(ResumeCreationVM.mock(userID: userID))
    }
}
