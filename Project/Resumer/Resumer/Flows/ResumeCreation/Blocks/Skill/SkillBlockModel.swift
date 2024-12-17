import Foundation


struct SkillBlockModel: Codable {
    let skills: [String]
    
    init(from viewModel: SkillBlockVM) {
        self.skills = viewModel.skills
    }
}
