import SwiftUI


class LanguageBlockVM: ObservableObject, Fillable {
    @Published var tiles: [LanguageTileVM]
    
    init(tiles: [LanguageTileVM] = []) {
        self.tiles = tiles
    }
    
    func addTile() {
        tiles.append(LanguageTileVM())
    }
    
    func removeTile(id: UUID) {
        tiles.removeAll { $0.id == id }
    }
    
    var isFilled: Bool {
        tiles.allSatisfy { $0.isFilled }
    }
}

extension LanguageBlockVM {
    func toDictionary() -> [String: Any] {
        return [
            "tiles": tiles.map { $0.toDictionary() } // Convert each tile to a dictionary
        ]
    }
}
