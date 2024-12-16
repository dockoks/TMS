import SwiftUI


struct ContactInfoView: View {
    @ObservedObject var viewModel: ContactInfoBlockVM = .init()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                VStack(spacing: 8) {
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
                        isValid: $viewModel.isPhoneValid,
                        symbolLimit: 30,
                        placeholder: "+34 958 800 73 77",
                        keyboardType: .phonePad
                    )
                }
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(ColorPalette.Bg.accent)
                )
                if !viewModel.additionalLinks.isEmpty {
                    VStack(spacing: 8) {
                        ForEach($viewModel.additionalLinks) { $link in
                            HStack(spacing: 8) {
                                RIconButton(
                                    icon: link.key.icon,
                                    style: .tertiary,
                                    size: .M
                                ) {
                                    viewModel.changeLinkDomain(by: $link.id)
                                }
                                RTextField(
                                    text: $link.value,
                                    symbolLimit: 22,
                                    placeholder: link.key.rawValue,
                                    keyboardType: .phonePad
                                )
                                RIconButton(
                                    icon: .minus,
                                    style: .tertiary,
                                    size: .M
                                ) {
                                    viewModel.removeLink(by: $link.id)
                                }
                            }
                        }
                    }
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(ColorPalette.Bg.accent)
                    )
                }
                RButton(
                    style: .secondary,
                    title: "Add social"
                ) {
                    viewModel.addLink()
                }
                
                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .scrollIndicators(.hidden)
        .dismissKeyboardOnTap()
    }
}

#Preview {
    @Previewable @ObservedObject var vm = ContactInfoBlockVM()
    
    ContactInfoView(viewModel: vm)
    
}
