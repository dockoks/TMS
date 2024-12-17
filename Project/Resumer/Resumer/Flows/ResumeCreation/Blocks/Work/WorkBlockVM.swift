import SwiftUI


final class WorkBlockVM: ObservableObject, Fillable {
    @Published var tiles: [WorkTileVM]
    
    init(tiles: [WorkTileVM] = []) {
        self.tiles = tiles
    }
    
    init(from model: WorkBlockModel) {
        self.tiles = model.tiles.map { WorkTileVM(from: $0) }
    }
    
    func addTile() {
//        tiles.append(WorkTileVM())
    }
    
    func removeTile(id: String) {
        tiles.removeAll { $0.id == id }
    }
    
    var isFilled: Bool {
        tiles.allSatisfy { $0.isFilled }
    }
}

extension WorkBlockVM: Uploadable {
    func toModel() -> WorkBlockModel {
        return WorkBlockModel(from: self)
    }
}
