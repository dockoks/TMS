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
            VStack(spacing: 8) {
                ForEach($viewModel.tiles) { $tile in
                    WorkTileView(tile: $tile)
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
            .padding(.horizontal, 16)
            
            RButton(
                style: .secondary,
                title: "Add Period"
            ) {
                viewModel.addTile()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .dismissKeyboardOnTap()
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    WorkBlockView()
}
