import SwiftUI

struct EducationBlockModel: Codable {
    let tiles: [EducationTileModel]
    
    init(from viewModel: EducationBlockVM) {
        self.tiles = viewModel.tiles.map { EducationTileModel(from: $0) }
    }
}

