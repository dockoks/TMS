//
//  WorkBlockView.swift
//  Resumer
//
//  Created by Danila Kokin on 12/4/24.
//

import SwiftUI

struct WorkBlockView: View {
    @ObservedObject var viewModel: WorkBlockVM = .init()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 4) {
                ForEach($viewModel.tiles) { $tile in
                    WorkTileView(tile: $tile)
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
    WorkBlockView()
}
