import SwiftUI


struct RProgressIndicatorView: View {
    @Binding var currentPage: Int
    
    let segments: [Block]
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                HStack(spacing: 4) {
                    ForEach(0..<segments.count, id: \.self) { index in
                        RProgressButton(
                            buttonIndex: index,
                            currentPage: $currentPage,
                            icon: segments[index].icon,
                            title: segments[index].displayName
                        )
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
            .onChange(of: currentPage) {
                withAnimation {
                    proxy.scrollTo(segments[currentPage], anchor: .center)
                }
            }
        }
    }
}


#Preview {
    @Previewable @State var currentPage: Int = 5
    
    RProgressIndicatorView(currentPage: $currentPage, segments: Block.allCases)
}
