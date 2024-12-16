import SwiftUI


final class WorkBlockVM: ObservableObject, Fillable {
    @Published var tiles: [WorkTileVM]
    
    init(tiles: [WorkTileVM] = []) {
        self.tiles = tiles
    }
    
    func addTile() {
        tiles.append(WorkTileVM())
    }
    
    func removeTile(id: UUID) {
        tiles.removeAll { $0.id == id }
    }
    
    var isFilled: Bool {
        tiles.allSatisfy { $0.isFilled }
    }
}

extension WorkBlockVM {
    func toDictionary() -> [String: Any] {
        return [
            "tiles": tiles.map { $0.toDictionary() }
        ]
    }
}
