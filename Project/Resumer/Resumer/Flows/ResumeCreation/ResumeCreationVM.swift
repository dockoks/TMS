import SwiftUI
import FirebaseFirestore
import Combine


final class ResumeCreationVM: ObservableObject, Identifiable {
    var userID: UUID = UUID()
    var resumeID: UUID = UUID()
    @Published var currentPage: Int = 0
    @Published var isDismissed: Bool = false
    @Published var pdfURL: URL?
    
    @Published var basicInfoVM: BasicInfoBlockVM
    @Published var contactVM: ContactInfoBlockVM
    @Published var educationVM: EducationBlockVM
    @Published var workVM: WorkBlockVM
    @Published var skillVM: SkillBlockVM
    @Published var languageVM: LanguageBlockVM
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(
        userID: UUID = UUID(),
        resumeID: UUID = UUID(),
        basicInfo: BasicInfoBlockVM = BasicInfoBlockVM(),
        contact: ContactInfoBlockVM = ContactInfoBlockVM(),
        education: EducationBlockVM = EducationBlockVM(tiles: [.init()]),
        work: WorkBlockVM = WorkBlockVM(tiles: [.init()]),
        skill: SkillBlockVM = SkillBlockVM(),
        language: LanguageBlockVM = LanguageBlockVM(tiles: [.init()])
    ) {
        self.userID = userID
        self.resumeID = resumeID
        
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
            .sink { [weak self] page in
                print("Current page changed to: \(page)")
                await uploadResume(forPage: page)
            }
            .store(in: &subscriptions)
    }
    
    private func uploadResume(forPage page: Int) async {
        var resumeData: [String: Any] = [:]
        
        switch page {
        case 0: resumeData["basic_info"] = basicInfoVM.toDictionary()
        case 1: resumeData["basic_info"] = basicInfoVM.toDictionary()
        case 2: resumeData["contact"] = contactVM.toDictionary()
        case 3: resumeData["education"] = educationVM.toDictionary()
        case 4: resumeData["work"] = workVM.toDictionary()
        case 5: resumeData["skill"] = skillVM.toDictionary()
        case 6: resumeData["language"] = languageVM.toDictionary()
        default:
            print("Nothing to update")
        }
        resumeData["updatedAt"] = Timestamp(date: Date())
        
        do {
            try await FirebaseStorageManager.shared.uploadData(
                for: userID.uuidString,
                resumeID: resumeID.uuidString,
                data: resumeData)
        } catch {
            
        }
    }
}

extension ResumeCreationVM {
    static func mock(userID: UUID) -> ResumeCreationVM {
        return ResumeCreationVM(
            userID: userID,
            resumeID: UUID(),
            basicInfo: .init(
                avatar: nil,
                name: "John",
                surname: "Doe",
                jobTitle: "iOS Developer"
            ),
            contact: .init(
                email: "johndoe@example.com",
                phone: "+346581234567",
                address: "123 Main Street, Springfield, USA",
                additionalLinks: [
                    .init(key: .linkedIn, value: "johndoe"),
                    .init(key: .github, value: "johndoe-dev")
                ]
            ),
            education: .init(
                tiles: [
                    .init(
                        affiliation: "Springfield University",
                        specialisation: "Computer Science",
                        degree: .postgraduate,
                        startDate: Date(timeIntervalSinceNow: -4 * 365 * 24 * 60 * 60), // 4 years ago
                        endDate: Date(timeIntervalSinceNow: -1 * 365 * 24 * 60 * 60), // 1 year ago
                        isPresent: false,
                        description: "Learned programming, data structures, and algorithms."
                    )
                ]
            ),
            work: .init(
                tiles: [
                    .init(
                        company: "TechCorp",
                        position: "Junior iOS Developer",
                        startDate: Date(timeIntervalSinceNow: -1 * 365 * 24 * 60 * 60), // 1 year ago
                        endDate: Date(),
                        isPresent: true,
                        description: "Developed and maintained iOS applications for e-commerce clients."
                    )
                ]
            ),
            skill: .init(
                skills: ["Swift", "SwiftUI", "Combine", "Core Data"]
            ),
            language: .init(
                tiles: [
                    .init(
                        name: "English",
                        chosenProficiency: 4,
                        proficiency: .c2
                    ),
                    .init(
                        name: "Spanish",
                        chosenProficiency: 3,
                        proficiency: .b2
                    )
                ]
            )
        )
    }
}
