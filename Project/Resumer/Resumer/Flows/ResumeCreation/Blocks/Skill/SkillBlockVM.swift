import SwiftUI


final class SkillBlockVM: ObservableObject, Fillable {
    @Published var skills: [String]
    
    init(skills: [String] = []) {
        self.skills = skills
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

extension SkillBlockVM {
    func toDictionary() -> [String] {
        return skills
    }
}
