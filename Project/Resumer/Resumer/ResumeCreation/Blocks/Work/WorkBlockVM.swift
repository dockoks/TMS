//
//  WorkExperienceBlock.swift
//  Resumer
//
//  Created by Danila Kokin on 12/4/24.
//
import SwiftUI


class WorkBlockVM: ObservableObject, Fillable {
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
