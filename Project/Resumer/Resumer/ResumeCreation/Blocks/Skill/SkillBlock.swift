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
        VStack(alignment: .leading, spacing: 12) {
            RTextField(
                text: $skillText,
                symbolLimit: 20,
                placeholder: "Enter a skill"
            )
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(ColorPalette.Bg.accent)
            )
            .onSubmit {
                addSkill()
            }
            
            FlowLayout(items: viewModel.skills, spacing: 8) { skill, index in
                Button {
                    viewModel.removeSkill(at: index)
                    
                } label: {
                    Text(skill)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .foregroundColor(.black)
                        .background(
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(ColorPalette.Bg.layerOne)
                        )
                }
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

class SkillBlockVM: ObservableObject, Fillable {
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
