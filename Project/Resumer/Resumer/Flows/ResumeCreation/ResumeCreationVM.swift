import SwiftUI
import FirebaseFirestore
import Combine

final class ResumeCreationVM: ObservableObject, Identifiable {
    var userID: String
    @DocumentID var resumeID: String?
    @Published var currentPage: Int = 0
    @Published var isDismissed: Bool = false
    let createdAt: Date
    var updatedAt: Date

    @Published var basicInfoVM: BasicInfoBlockVM
    @Published var contactVM: ContactBlockVM
    @Published var educationVM: EducationBlockVM
    @Published var workVM: WorkBlockVM
    @Published var skillVM: SkillBlockVM
    @Published var languageVM: LanguageBlockVM

    private var subscriptions = Set<AnyCancellable>()

    init(
        userID: String,
        resumeID: String? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        basicInfo: BasicInfoBlockVM = BasicInfoBlockVM(),
        contact: ContactBlockVM = ContactBlockVM(),
        education: EducationBlockVM = EducationBlockVM(tiles: [.init()]),
        work: WorkBlockVM = WorkBlockVM(tiles: [.init()]),
        skill: SkillBlockVM = SkillBlockVM(skills: []),
        language: LanguageBlockVM = LanguageBlockVM(tiles: [.init()])
    ) {
        self.userID = userID
        self.resumeID = resumeID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        
        self.basicInfoVM = basicInfo
        self.contactVM = contact
        self.educationVM = education
        self.workVM = work
        self.skillVM = skill
        self.languageVM = language

        setupCurrentPageListener()
    }

    var isCurrentTabFilled: Bool {
        switch currentPage {
        case 0: return basicInfoVM.isFilled
        case 1: return contactVM.isFilled
        case 2: return educationVM.isFilled
        case 3: return workVM.isFilled
        case 4: return skillVM.isFilled
        case 5: return languageVM.isFilled
        default: return false
        }
    }

    func navigateToPreviousTab() {
        if currentPage == 0 {
            isDismissed = true
        } else if currentPage > 0 {
            currentPage -= 1
        }
    }

    func navigateToNextTab() {
        if currentPage < 6 {
            currentPage += 1
        }
    }
    
    private func setupCurrentPageListener() {
        $currentPage
            .removeDuplicates()
            .sink { [weak self] _ in
                Task {
                    await self?.saveResume()
                }
            }
            .store(in: &subscriptions)
    }

    // MARK: - Save Resume to Firestore
    func saveResume() async {
        let db = Firestore.firestore()
        let resumeModel = toModel()

        do {
            let data = try Firestore.Encoder().encode(resumeModel)
            let documentRef = db.collection("users")
                .document(userID)
                .collection("resumes")
                .document(resumeID ?? UUID().uuidString)

            try await documentRef.setData(data, merge: true)

            self.resumeID = documentRef.documentID
            self.updatedAt = Date()
            print("Resume saved successfully!")
        } catch {
            print("Error saving resume: \(error.localizedDescription)")
        }
    }

    // MARK: - Convert ViewModel to ResumeModel
    func toModel() -> ResumeModel {
        return ResumeModel(from: self)
    }
}
