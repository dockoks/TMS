//
//  ProgressIndicator.swift
//  Resumer
//
//  Created by Danila Kokin on 11/29/24.
//

import SwiftUI

struct ProgressIndicator: View {
    @Binding var currentPage: Int
    
    let segments: [(String, String)] = [
        ("person.fill", "Template"),
        ("person.fill", "Basic Info"),
        ("person.fill", "Contact Info"),
        ("person.fill", "Education"),
        ("person.fill", "Work"),
        ("person.fill", "Skills"),
        ("person.fill", "Language"),
    ]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 4) {
                ForEach(0..<segments.count, id: \.self) { index in
                    ProgressButton(
                        buttonIndex: index,
                        currentPage: $currentPage,
                        iconName: segments[index].0,
                        title: segments[index].1
                    )
                }
            }
            .padding()
        }
    }
}

struct ProgressButton: View {
    @State var buttonIndex: Int = 0
    @Binding var currentPage: Int
    var iconName: String
    var title: String
    
    var body: some View {
        Button {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                currentPage = buttonIndex
            }
        } label: {
            HStack(spacing: 8) {
                Image(systemName: iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(buttonIndex == currentPage ? .white : .black)
                    .scaleEffect(buttonIndex == currentPage ? 1.2 : 1) // Animate scale
                    .animation(.easeInOut(duration: 0.3), value: currentPage) // Smooth scaling

                if buttonIndex == currentPage {
                    Text(title)
                        .typographyStyle(.caption)
                        .transition(.opacity) // Fade-in animation
                        .animation(.easeInOut(duration: 0.1), value: currentPage)
                }
            }
        }
        .padding(8)
        .frame(height: 40)
        .frame(width: buttonIndex != currentPage ? 40 : nil) // Adjust width dynamically
        .foregroundStyle(buttonIndex == currentPage ? ColorPalette.Bg.accent : .black)
        .opacity(buttonIndex > currentPage ? 0.3 : 1) // Disable higher buttons visually
        .disabled(buttonIndex > currentPage)
        .buttonStyle(NoneButtonStyle())
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(buttonIndex == currentPage ? .black : .gray.opacity(0.2))
                .animation(.easeInOut(duration: 0.3), value: currentPage) // Smooth background change
        }
        .animation(.easeInOut(duration: 0.3), value: currentPage) // Smooth width change
    }
}


#Preview {
    ProgressIndicator(currentPage: .constant(3))
}
