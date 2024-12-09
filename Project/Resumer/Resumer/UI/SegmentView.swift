//
//  SegmentView.swift
//  Resumer
//
//  Created by Danila Kokin on 12/4/24.
//


import SwiftUI

struct SegmentView: View {
    @Binding var currentTab: Int
    let namespace: Namespace.ID
    let title: String
    let tab: Int
    
    var body: some View {
        Button {
            currentTab = tab
        } label: {
            HStack {
                VStack(spacing: 4) {
                    Text(title)
                        .typographyStyle(.body)
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity)
            }
            .padding()
            .foregroundStyle(tab == currentTab ? ColorPalette.Text.primary : ColorPalette.Text.secondary)
            .frame(height: 60)
            .cornerRadius(14)
        }
        .matchedGeometryEffect(
            id: tab,
            in: namespace,
            isSource: true
        )
        .buttonStyle(NoneButtonStyle())
    }
}
