//
//  ContactInfoView.swift
//  Resumer
//
//  Created by Danila Kokin on 11/29/24.
//

import SwiftUI

struct ContactInfoView: View {
    @ObservedObject var viewModel: ContactInfoBlockVM = .init()
    
    var body: some View {
        VStack(spacing: 8) {
            Spacer()

            VStack {
                RTextField(
                    text: $viewModel.email,
                    symbolLimit: 30,
                    placeholder: "email@example.com",
                    keyboardType: .emailAddress
                )
                RTextField(
                    text: $viewModel.address,
                    symbolLimit: 30,
                    placeholder: "Address",
                    keyboardType: .default
                )
                RTextField(
                    text: $viewModel.phone,
                    isValid: viewModel.isPhoneValid,
                    symbolLimit: 30,
                    placeholder: "+34 958 800 73 77",
                    keyboardType: .phonePad
                )
            }
            
            ForEach($viewModel.additionalLinks) { $link in
                RTextField(
                    text: $link.value,
                    symbolLimit: 22,
                    placeholder: link.key.rawValue,
                    keyboardType: .phonePad
                )
            }
            
            Spacer()
            
            RButton(
                style: .secondary,
                title: "Add social"
            ) {}
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .dismissKeyboardOnTap()
    }
}

#Preview {
    ContactInfoView()
}
