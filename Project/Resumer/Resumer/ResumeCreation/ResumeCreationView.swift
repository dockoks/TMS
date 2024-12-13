//
//  Resume.swift
//  Resumer
//
//  Created by Danila Kokin on 11/29/24.
//

import SwiftUI


struct ResumeCreationView: View {
    @ObservedObject private var resumeVM: ResumeCreationVM
    @Environment(\.dismiss) private var dismiss
    @StateObject private var keyboardResponder = KeyboardResponder()
    
    init(resumeVM: ResumeCreationVM) {
        self.resumeVM = resumeVM
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 12) {
                RProgressIndicatorView(currentPage: $resumeVM.currentPage, segments: Block.allCases)
                
                TabView(selection: $resumeVM.currentPage) {
                    BasicInfoView(basicInfo: resumeVM.basicInfoVM)
                        .tag(0)
                    BasicInfoView(basicInfo: resumeVM.basicInfoVM)
                        .tag(1)
                    ContactInfoView(viewModel: resumeVM.contactVM)
                        .tag(2)
                    EducationBlockView(viewModel: resumeVM.educationVM)
                        .tag(3)
                    WorkBlockView(viewModel: resumeVM.workVM)
                        .tag(4)
                    SkillBlockView(viewModel: resumeVM.skillVM)
                        .tag(5)
                    LanguageBlockView(viewModel: resumeVM.languageVM)
                        .tag(6)
                    RenderedView(resumeVM: resumeVM)
                        .tag(7)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            
            HStack {
                RIconButton(icon: .chevronL, style: .secondary) {
                    withAnimation(.easeInOut) {
                        resumeVM.navigateToPreviousTab()
                    }
                }
                Spacer()
                RIconButton(icon: .chevronR, isEnabled: .constant(resumeVM.isCurrentTabFilled)) {
                    withAnimation(.easeInOut) {
                        resumeVM.navigateToNextTab()
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, keyboardResponder.keyboardHeight > 0 ? 16 : 0)
        }
        .onChange(of: resumeVM.isDismissed) {
            if resumeVM.isDismissed {
                dismiss()
            }
        }
        .onChange(of: resumeVM.currentPage) {
            UIApplication.shared.sendAction(
                #selector(UIResponder.resignFirstResponder),
                to: nil,
                from: nil,
                for: nil
            )
        }
        .animation(.easeInOut, value: keyboardResponder.keyboardHeight)
        .navigationBarBackButtonHidden(true)
    }
}
