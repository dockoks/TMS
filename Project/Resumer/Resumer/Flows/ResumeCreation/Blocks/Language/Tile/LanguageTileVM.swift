import SwiftUI


final class LanguageTileVM: ObservableObject, Identifiable, Fillable {
    @Published var name: String
    @Published var proficiency: ProfficiencyLevel
    @Published var proficiencySelected: Int = 0
    let id: String
    
    init(
        name: String = "",
        proficiency: ProfficiencyLevel = .a1
    ) {
        self.id = UUID().uuidString
        self.name = name
        self.proficiency = proficiency
        ProfficiencyLevel.allCases.enumerated().forEach { proficiencySelected, proficiencyLevel in
            if proficiency == proficiencyLevel {
                self.proficiencySelected = proficiencySelected
            }
        }
    }
    
    init(from model: LanguageTileModel) {
        self.id = model.id
        self.name = model.name
        self.proficiency = ProfficiencyLevel(rawValue: model.proficiency) ?? .a1
    }
    
    var isFilled: Bool {
        !name.isEmpty
    }
}
