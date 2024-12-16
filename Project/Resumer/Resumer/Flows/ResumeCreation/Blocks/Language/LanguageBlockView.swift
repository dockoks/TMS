import SwiftUI


struct LanguageBlockView: View {
    @ObservedObject var viewModel: LanguageBlockVM = .init()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach($viewModel.tiles) { $tile in
                    LanguageTileView(tile: $tile)
                        .padding(.horizontal, 16)
                        .swipeActions(
                            edge: .trailing,
                            allowsFullSwipe: true
                        ) {
                            Button(role: .destructive) {
                                viewModel.removeTile(id: $tile.id)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
            RButton(style: .secondary, title: "Add Period") {
                viewModel.addTile()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .dismissKeyboardOnTap()
        }
        .scrollIndicators(.hidden)
        .dismissKeyboardOnTap()
    }
}

#Preview {
    @Previewable @ObservedObject var vm = LanguageBlockVM.init(tiles: [.init()])
    
    LanguageBlockView(viewModel: vm)
}
