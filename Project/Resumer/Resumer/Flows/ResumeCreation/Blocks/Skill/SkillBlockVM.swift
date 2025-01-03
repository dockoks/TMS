import SwiftUI


final class SkillBlockVM: ObservableObject, Fillable {
    @Published var skills: [String]
    
    init(skills: [String] = []) {
        self.skills = skills
    }
    
    init(from model: SkillBlockModel) {
        self.skills = model.skills
    }
    
    func addSkill(_ skill: String) {
        guard !skills.contains(skill) else { return }
        skills.append(skill)
    }
    
    func removeSkill(at index: Int) {
        guard index < skills.count && skills.count > 0 else { return }
        skills.remove(at: index)
    }
    
    var isFilled: Bool {
        return !skills.isEmpty
    }
}

extension SkillBlockVM: Uploadable{
    func toModel() -> SkillBlockModel {
        return SkillBlockModel(from: self)
    }
}
