import SwiftUI


final class LanguageBlockVM: ObservableObject, Fillable {
    @Published var tiles: [LanguageTileVM]
    
    init(tiles: [LanguageTileVM] = []) {
        self.tiles = tiles
    }
    
    init(from model: LanguageBlockModel) {
        self.tiles = model.tiles.map { .init(from: $0) }
    }
    
    func addTile() {
        tiles.append(LanguageTileVM())
    }
    
    func removeTile(id: String) {
        tiles.removeAll { $0.id == id }
    }
    
    var isFilled: Bool {
        tiles.allSatisfy { $0.isFilled }
    }
}

extension LanguageBlockVM: Uploadable {
    func toModel() -> LanguageBlockModel {
        return LanguageBlockModel(from: self)
    }
}
