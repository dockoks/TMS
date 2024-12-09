//
//  SkillBlock.swift
//  Resumer
//
//  Created by Danila Kokin on 12/4/24.
//

import SwiftUI


struct SkillBlockView: View {
    @ObservedObject var viewModel: SkillBlockVM = .init()
    @State var skillText: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // TextField to input skills
            RTextField(
                text: $skillText,
                symbolLimit: 20,
                placeholder: "Enter a skill"
            )
            .onSubmit {
                addSkill()
            }
            
            FlowLayout(items: viewModel.skills, spacing: 8) { skill, index in
                HStack(spacing: 4) {
                    Text(skill)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(16)
                        .foregroundColor(.blue)
                    
                    Button {
                        viewModel.removeSkill(at: index)
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.red)
                    }
                }
                .padding(.vertical, 4)
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
    }
    private func addSkill() {
        guard !skillText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        viewModel.addSkill(skillText.trimmingCharacters(in: .whitespacesAndNewlines))
        skillText = ""
    }
    
}

#Preview {
    SkillBlockView()
}

class SkillBlockVM: ObservableObject {
    @Published var skills: [String]
    
    init(skills: [String] = ["Swift", "SwiftUI", "UIKit", "CoreData", "CoreLocation", "Combine"]) {
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
}
