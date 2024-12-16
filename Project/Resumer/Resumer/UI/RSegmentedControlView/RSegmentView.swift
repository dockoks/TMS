//
//  RSegmentView.swift
//  Resumer
//
//  Created by Danila Kokin on 12/16/24.
//


struct RSegmentView: View {
    @Binding var currentTab: Int
    let namespace: Namespace.ID
    let title: String
    let tab: Int
    
    var body: some View {
        Button {
            currentTab = tab
        } label: {
            Text(title)
                .padding(4)
                .frame(minWidth: 36, minHeight: 36)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .typographyStyle(.caption)
                .foregroundStyle(tab == currentTab ? .black : .gray)
        }
        .matchedGeometryEffect(
            id: tab,
            in: namespace,
            isSource: true
        )
        .buttonStyle(NoneButtonStyle())
    }
}