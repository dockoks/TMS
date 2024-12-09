//
//  BasicInfoView.swift
//  Resumer
//
//  Created by Danila Kokin on 11/29/24.
//

import SwiftUI

struct BasicInfoView: View {
    @ObservedObject var basicInfo: BasicInfoBlockVM = .init()
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Button (action: {
                print("select photo")
            }) {
                if let avatar = basicInfo.avatar {
                    avatar
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                } else {
                    Circle()
                        .fill(ColorPalette.Outline.light)
                        .frame(width: 100, height: 100)
                        .overlay{
                            Image(systemName: "person.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                                .foregroundStyle(ColorPalette.Text.tertiary)
                        }
                }
            }
            .buttonStyle(NoneButtonStyle())
            Spacer()
            VStack(spacing: 8) {
                RTextField(
                    text: $basicInfo.name,
                    symbolLimit: 30,
                    placeholder: "First Name"
                )
                RTextField(
                    text: $basicInfo.surname,
                    symbolLimit: 30,
                    placeholder: "Last Name"
                )
                RTextField(
                    text: $basicInfo.jobTitle,
                    symbolLimit: 30,
                    placeholder: "Job Title"
                )
            }
            
            Spacer()
        }
        .padding(.horizontal, 24)
        .dismissKeyboardOnTap()
    }
}

#Preview {
    BasicInfoView()
}
