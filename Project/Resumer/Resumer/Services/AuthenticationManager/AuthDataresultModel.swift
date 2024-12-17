import Foundation
import FirebaseAuth


struct AuthDataResultModel {
    let uid: String
    let email: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
    }
    
    init(
        uuid: UUID = UUID(),
        email: String = ""
    ) {
        self.uid = uuid.uuidString
        self.email = email
    }
}
