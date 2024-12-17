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
    
    func fetchResumes(for userID: String) async throws -> [Resume] {
        let snapshot = try await db.collection("users")
            .document(userID)
            .collection("resumes")
            .getDocuments()
        
        let resumes: [Resume] = snapshot.documents.compactMap { document in
            do {
                return try document.data(as: Resume.self)
            } catch {
                print("Error decoding resume \(document.documentID): \(error)")
                return nil
            }
        }
        
        return resumes
    }
}

struct Resume: Codable, Identifiable {
    @DocumentID var id: String?
    var basicInfo: BasicInfo?
    var contact: Contact?
    var education: [Education]?
    var work: [WorkExperience]?
    var skill: [String]?
    var language: [Language]?
    var updatedAt: Date?
}

// MARK: - Supporting Models

struct BasicInfo: Codable {
    var name: String
    var jobTitle: String
    var surname: String
}

struct Contact: Codable {
    var email: String
    var phone: String
    var address: String
}

struct Education: Codable {
    var university: String
    var degree: String
    var startDate: Date
    var endDate: Date?
}

struct WorkExperience: Codable {
    var company: String
    var position: String
    var startDate: Date
    var endDate: Date?
    var description: String
}

struct Language: Codable {
    var name: String
    var level: String
}
