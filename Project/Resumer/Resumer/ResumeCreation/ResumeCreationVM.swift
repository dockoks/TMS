//
//  ResumeViewModel.swift
//  Resumer
//
//  Created by Danila Kokin on 12/5/24.
//


import SwiftUI

class ResumeCreationVM: ObservableObject {
    @Published var currentPage: Int = 0
    @Published var isDismissed: Bool = false
    @Published var pdfURL: URL?
    
    @Published var basicInfoVM: BasicInfoBlockVM
    @Published var contactVM: ContactInfoBlockVM
    @Published var educationVM: EducationBlockVM
    @Published var workVM: WorkBlockVM
    @Published var skillVM: SkillBlockVM
    @Published var languageVM: LanguageBlockVM
    
    init(
        basicInfo: BasicInfoBlockVM = BasicInfoBlockVM(),
        contact: ContactInfoBlockVM = ContactInfoBlockVM(),
        education: EducationBlockVM = EducationBlockVM(tiles: [.init()]),
        work: WorkBlockVM = WorkBlockVM(tiles: [.init()]),
        skill: SkillBlockVM = SkillBlockVM(),
        language: LanguageBlockVM = LanguageBlockVM(tiles: [.init()])
    ) {
        self.basicInfoVM = basicInfo
        self.contactVM = contact
        self.educationVM = education
        self.workVM = work
        self.skillVM = skill
        self.languageVM = language
    }
    
    var isCurrentTabFilled: Bool {
        switch currentPage {
        case 0: return basicInfoVM.isFilled
        case 1: return contactVM.isFilled
        case 2: return educationVM.isFilled
        case 3: return workVM.isFilled
        case 4: return !skillVM.skills.isEmpty
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
}
