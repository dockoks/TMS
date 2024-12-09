import SwiftUI


struct TabBarView: View {
    @Binding var currentTab: Int
    @Namespace var namespace

    var tabBarOptions: [String]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(tabBarOptions.enumerated()), id: \.offset) { id, name in
                TabBarTabView(
                    currentTab: $currentTab,
                    namespace: namespace,
                    title: name,
                    tab: id
                )
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 14)
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
            RoundedRectangle(cornerRadius: 16)
                .fill(.gray.opacity(0.2))
        }
        .animation(.easeInOut, value: currentTab)
    }
}

struct TabBarTabView: View {
    @Binding var currentTab: Int
    let namespace: Namespace.ID
    let title: String
    let tab: Int
    
    var body: some View {
        Button {
            currentTab = tab
        } label: {
            VStack(spacing: 4) {
                Text(title)
            }
            .padding(4)
            .frame(maxWidth: .infinity)
            .typographyStyle(.caption)
            .foregroundStyle(tab == currentTab ? .black : .gray)
            .frame(height: 48)
        }
        .matchedGeometryEffect(
            id: tab,
            in: namespace,
            isSource: true
        )
        .buttonStyle(NoneButtonStyle())
    }
}
