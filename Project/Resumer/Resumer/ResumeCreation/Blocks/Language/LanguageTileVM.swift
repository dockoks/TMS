//
//  LanguageTileVM.swift
//  Resumer
//
//  Created by Danila Kokin on 12/5/24.
//

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
