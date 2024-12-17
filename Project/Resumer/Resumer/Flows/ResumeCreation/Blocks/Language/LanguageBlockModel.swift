import Foundation


struct LanguageBlockModel: Codable {
    let tiles: [LanguageTileModel]
    
    init(tiles: [LanguageTileModel]) {
        self.tiles = tiles
    }
    
    init(from viewModel: LanguageBlockVM) {
        self.tiles = viewModel.tiles.map { LanguageTileModel(from: $0) }
    }
}
