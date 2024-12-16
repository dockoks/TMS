import SwiftUI


struct RSegmentedControlView: View {
    @Binding var currentTab: Int
    @Namespace var namespace
    
    var tabBarOptions: [String]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(tabBarOptions.enumerated()), id: \.offset) { id, name in
                RSegmentView(
                    currentTab: $currentTab,
                    namespace: namespace,
                    title: name,
                    tab: id
                )
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(.white)
                .shadow(color: .black.opacity(0.04), radius: 0.5, x: 0, y: 3)
                .shadow(color: .black.opacity(0.12), radius: 4, x: 0, y: 3)
                .matchedGeometryEffect(
                    id: currentTab,
                    in: namespace,
                    isSource: false
                )
        }
        .padding(2)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.gray.opacity(0.2))
        }
        .animation(.easeInOut, value: currentTab)
    }
}
