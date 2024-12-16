import SwiftUI


struct FlowLayout<Data: RandomAccessCollection, Content: View>: View where Data.Element: Hashable {
    let items: Data
    let spacing: CGFloat
    let content: (Data.Element, Int) -> Content

    @State private var totalHeight: CGFloat = .zero

    init(
        items: Data,
        spacing: CGFloat,
        @ViewBuilder content: @escaping (Data.Element, Int) -> Content
    ) {
        self.items = items
        self.spacing = spacing
        self.content = content
    }

    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
        .frame(height: totalHeight)
    }

    private func generateContent(in geometry: GeometryProxy) -> some View {
        var width: CGFloat = 0
        var height: CGFloat = 0

        return ZStack(alignment: .topLeading) {
            ForEach(Array(items.enumerated()), id: \.element) { index, item in
                content(item, index)
                    .padding(.leading, isFirstInRow(index: index, currentWidth: width, itemWidth: geometry.size.width) ? 0 : spacing)
                    .padding(.trailing, isLastInRow(index: index, currentWidth: width, geometry: geometry) ? 0 : spacing)
                    .alignmentGuide(.leading) { dimension in
                        if abs(width - dimension.width) > geometry.size.width {
                            width = 0
                            height -= dimension.height + spacing
                        }
                        let result = width
                        if index == items.count - 1 {
                            width = 0
                        } else {
                            width -= dimension.width
                        }
                        return result
                    }
                    .alignmentGuide(.top) { _ in
                        let result = height
                        if index == items.count - 1 {
                            height = 0
                        }
                        return result
                    }
            }
        }
        .background(viewHeightReader($totalHeight))
    }
    
    private func isFirstInRow(index: Int, currentWidth: CGFloat, itemWidth: CGFloat) -> Bool {
            currentWidth == 0 || abs(currentWidth - itemWidth) > itemWidth
        }

        private func isLastInRow(index: Int, currentWidth: CGFloat, geometry: GeometryProxy) -> Bool {
            let remainingWidth = geometry.size.width - currentWidth
            if index == items.count - 1 || remainingWidth < 0 {
                return true
            }
            return false
        }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        GeometryReader { geometry -> Color in
            DispatchQueue.main.async {
                binding.wrappedValue = geometry.size.height
            }
            return Color.clear
        }
    }
}
