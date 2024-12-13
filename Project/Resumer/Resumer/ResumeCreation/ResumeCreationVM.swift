//
//  ResumeViewModel.swift
//  Resumer
//
//  Created by Danila Kokin on 12/5/24.
//


import SwiftUI

enum Block: CaseIterable {
    case template
    case basic
    case contact
    case education
    case work
    case skill
    case language
    case preview
    
    var displayName: String {
        return switch self {
        case .template: "Template"
        case .basic: "Basic Info"
        case .contact: "Contacts"
        case .education: "Education"
        case .work: "Work"
        case .skill: "Skills"
        case .language: "Languages"
        case .preview: "Preview"
        }
    }
    
    var icon: Image {
        return switch self {
        case .template: Image(systemName: "paintpalette.fill")
        case .basic: Image(systemName: "person.fill")
        case .contact: Image(systemName: "phone.fill")
        case .education: Image(systemName: "graduationcap.fill")
        case .work: Image(systemName: "case.fill")
        case .skill: Image(systemName: "theatermask.and.paintbrush.fill")
        case .language: Image(systemName: "globe.europe.africa.fill")
        case .preview: Image(systemName: "text.page.fill")
        }
    }
}

class ResumeCreationVM: ObservableObject, Identifiable {
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
    
    static let mock = ResumeCreationVM(
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
