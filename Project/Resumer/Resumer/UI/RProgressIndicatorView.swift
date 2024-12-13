//
//  ProgressIndicator.swift
//  Resumer
//
//  Created by Danila Kokin on 11/29/24.
//

import SwiftUI

struct RProgressIndicatorView: View {
    @Binding var currentPage: Int
    @State var scrollToBlock: Int? = nil
    
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
                if currentPage == 0 || currentPage == segments.count - 1 {
                    scrollToBlock = currentPage
                } else {
                    scrollToBlock = nil
                }
            }
            .onChange(of: scrollToBlock) {
                if let scrollToBlock {
                    withAnimation {
                        proxy.scrollTo(scrollToBlock, anchor: .center)
                    }
                }
            }
        }
    }
}

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


#Preview {
    @Previewable @State var currentPage: Int = 5
    
    RProgressIndicatorView(currentPage: $currentPage, segments: Block.allCases)
}
