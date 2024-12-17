import SwiftUI


struct BasicInfoBlockView: View {
    @ObservedObject var viewModel: BasicInfoBlockVM = .init()
    
    var body: some View {
        VStack(spacing:40) {
            Button (action: {
                print("select photo")
            }) {
                if let avatar = viewModel.avatar {
                    avatar
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .background(Circle().fill(Color.gray))
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
            VStack(spacing: 8) {
                RTextField(
                    text: $viewModel.name,
                    symbolLimit: 30,
                    placeholder: "First Name"
                )
                RTextField(
                    text: $viewModel.surname,
                    symbolLimit: 30,
                    placeholder: "Last Name"
                )
                RTextField(
                    text: $viewModel.jobTitle,
                    symbolLimit: 30,
                    placeholder: "Job Title"
                )
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(ColorPalette.Bg.accent)
            )
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 40)
        .dismissKeyboardOnTap()
        .gesture(DragGesture().onChanged { _ in })
    }
}

#Preview {
    BasicInfoBlockView()
}
