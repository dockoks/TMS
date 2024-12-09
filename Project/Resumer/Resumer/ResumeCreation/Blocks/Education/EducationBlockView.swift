//
//  EducationBlockView.swift
//  Resumer
//
//  Created by Danila Kokin on 11/29/24.
//

import SwiftUI

struct EducationBlockView: View {
    @ObservedObject var viewModel: EducationBlockVM = .init()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 4) {
                ForEach($viewModel.tiles) { $tile in
                    EducationTileView(tile: $tile)
                        .padding(.horizontal, 12)
                        .swipeActions(
                            edge: .trailing,
                            allowsFullSwipe: true
                        ) {
                            Button(role: .destructive) {
                                if let index = viewModel.tiles.firstIndex(where: { $0.id == tile.id }) {
                                    viewModel.tiles.remove(at: index)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
            RButton(
                style: .secondary,
                title: "Add Period"
            ) {
                viewModel.addTile()
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 8)
            .dismissKeyboardOnTap()
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    EducationBlockView()
}
