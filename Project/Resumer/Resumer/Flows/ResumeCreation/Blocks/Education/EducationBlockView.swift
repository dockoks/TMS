import SwiftUI


struct EducationBlockView: View {
    @ObservedObject var viewModel: EducationBlockVM = .init()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach($viewModel.tiles) { $tile in
                    EducationTileView(tile: $tile)
                        .padding(.horizontal, 16)
                        .swipeActions(
                            edge: .trailing,
                            allowsFullSwipe: true
                        ) {
                            Button(role: .destructive) {
                                viewModel.removeTile(by: $tile.id)
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
            .padding(.horizontal, 16*2+48)
            .padding(.top, 8)
            .padding(.bottom, 16)
            .dismissKeyboardOnTap()
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    @Previewable @ObservedObject var vm = EducationBlockVM.init(tiles: [.init()])
    
    EducationBlockView(viewModel: vm)
}
