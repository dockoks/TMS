import SwiftUI


class LanguageTileVM: ObservableObject, Identifiable {
    @Published var name: String
    @Published var proficiency: ProfficiencyLevel
    
    @Published var chosenProficiency: Int
    
    let id = UUID()
    
    init(
        name: String = "",
        chosenProficiency: Int = 0,
        proficiency: ProfficiencyLevel = .a1
    ) {
        self.name = name
        self.chosenProficiency = chosenProficiency
        self.proficiency = proficiency
        
        ProfficiencyLevel.allCases.enumerated().forEach { index, proficiencyLevel in
            if proficiencyLevel == self.proficiency { self.chosenProficiency = index }
        }
    }
    
    var isFilled: Bool {
        !name.isEmpty
    }
}

import FirebaseFirestore

extension LanguageTileVM {
    func toDictionary() -> [String: Any] {
        return [
            "id": id.uuidString, // Firestore-compatible UUID string
            "name": name,
            "proficiency": proficiency.rawValue, // Enum as string
            "chosenProficiency": chosenProficiency // Integer for chosen proficiency level
        ]
    }
}
