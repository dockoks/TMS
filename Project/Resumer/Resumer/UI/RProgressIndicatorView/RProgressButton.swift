import SwiftUI


struct RProgressButton: View {
    @State var buttonIndex: Int = 0
    @Binding var currentPage: Int
    var icon: Image
    var title: String
    
    var body: some View {
        Button {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                currentPage = buttonIndex
            }
        } label: {
            HStack(spacing: 8) {
                icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(buttonIndex == currentPage ? .white : .black)
                    .animation(.easeInOut(duration: 0.3), value: currentPage)
                
                if buttonIndex == currentPage {
                    Text(title)
                        .typographyStyle(.caption)
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 0.1), value: currentPage)
                }
            }
        }
        .padding(8)
        .frame(height: 40)
        .frame(width: buttonIndex != currentPage ? 40 : nil)
        .foregroundStyle(buttonIndex == currentPage ? ColorPalette.Bg.accent : .black)
        .opacity(buttonIndex > currentPage ? 0.3 : 1)
        .disabled(buttonIndex > currentPage)
        .buttonStyle(NoneButtonStyle())
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(buttonIndex == currentPage ? .black : .gray.opacity(0.2))
                .animation(.easeInOut(duration: 0.3), value: currentPage)
        }
        .animation(.easeInOut(duration: 0.3), value: currentPage)
    }
}
