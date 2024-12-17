import Foundation
import FirebaseFirestore

// MARK: - ResumeModel
struct ResumeModel: Codable, Identifiable {
    @DocumentID var id: String?
    let createdAt: Date
    let updatedAt: Date
    let basicInfo: BasicInfoModel?
    let contact: ContactBlockModel?
    let education: EducationBlockModel?
    let work: WorkBlockModel?
    let skills: SkillBlockModel?
    let languages: LanguageBlockModel?
    
    init(from viewModel: ResumeCreationVM) {
        self.id = viewModel.resumeID
        self.createdAt = viewModel.createdAt
        self.updatedAt = viewModel.updatedAt
        self.basicInfo = viewModel.basicInfoVM.toModel()
        self.contact = viewModel.contactVM.toModel()
        self.education = viewModel.educationVM.toModel()
        self.work = viewModel.workVM.toModel()
        self.skills = viewModel.skillVM.toModel()
        self.languages = viewModel.languageVM.toModel()
    }
}
