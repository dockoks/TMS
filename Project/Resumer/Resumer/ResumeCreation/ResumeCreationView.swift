//
//  Resume.swift
//  Resumer
//
//  Created by Danila Kokin on 11/29/24.
//

import SwiftUI


struct ResumeCreationView: View {
    @StateObject private var resumeVM = ResumeCreationVM(
        basicInfo: .init(
            avatar: Image(systemName: "person.circle"),
            name: "John",
            surname: "Doe",
            jobTitle: "iOS Developer"
        ),
        contact: .init(
            email: "johndoe@example.com",
            phone: "+1 (555) 123-4567",
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
                    degree: .bachelors,
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
    @Environment(\.dismiss) private var dismiss
    @StateObject private var keyboardResponder = KeyboardResponder()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                ProgressIndicator(currentPage: $resumeVM.currentPage)
                
                TabView(selection: $resumeVM.currentPage) {
                    BasicInfoView(basicInfo: resumeVM.basicInfoVM)
                        .tag(0)
                    ContactInfoView(viewModel: resumeVM.contactVM)
                        .tag(1)
                    EducationBlockView(viewModel: resumeVM.educationVM)
                        .tag(2)
                    WorkBlockView(viewModel: resumeVM.workVM)
                        .tag(3)
                    SkillBlockView(viewModel: resumeVM.skillVM)
                        .tag(4)
                    LanguageBlockView(viewModel: resumeVM.languageVM)
                        .tag(5)
                    RenderedView(resumeVM: resumeVM)
                        .tag(6)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            
            HStack {
                RIconButton(style: .secondary) {
                    resumeVM.navigateToPreviousTab()
                }
                Spacer()
                RIconButton(isEnabled: .constant(resumeVM.isCurrentTabFilled)) {
                    resumeVM.navigateToNextTab()
                }
            }
            .padding(16)
            .padding(.bottom, keyboardResponder.keyboardHeight > 0 ? keyboardResponder.keyboardHeight - 16 : 0)
        }
        .onChange(of: resumeVM.isDismissed) {
            if resumeVM.isDismissed {
                dismiss()
            }
        }
        .animation(.easeInOut, value: keyboardResponder.keyboardHeight)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ResumeCreationView()
}
