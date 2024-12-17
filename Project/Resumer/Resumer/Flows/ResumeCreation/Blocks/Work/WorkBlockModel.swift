import Foundation


struct WorkBlockModel: Codable {
    let tiles: [WorkTileModel]
    
    init(tiles: [WorkTileModel]) {
        self.tiles = tiles
    }
    
    init(from viewModel: WorkBlockVM) {
        self.tiles = viewModel.tiles.map { WorkTileModel(from: $0 ) }
    }
}
