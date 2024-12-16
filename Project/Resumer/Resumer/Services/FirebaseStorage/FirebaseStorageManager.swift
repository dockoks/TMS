import SwiftUI
import FirebaseFirestore

final class FirebaseStorageManager {
    static let shared = FirebaseStorageManager()
    private let db = Firestore.firestore()
    
    private init() {}
    
    func uploadData(for userID: String, resumeID: String, data: [String: Any]) async throws {
        try await db.collection("users")
            .document(userID)
            .collection("resumes")
            .document(resumeID)
            .setData(data, merge: true)
    }
    
    func deleteData(for userID: String, resumeID: String) async throws {
        let documentRef = db.collection("users")
            .document(userID)
            .collection("resumes")
            .document(resumeID)
        
        try await documentRef.delete()
    }
}
