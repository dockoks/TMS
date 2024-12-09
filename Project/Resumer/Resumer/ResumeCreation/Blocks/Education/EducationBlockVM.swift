//
//  EducationBlockVM.swift
//  Resumer
//
//  Created by Danila Kokin on 12/3/24.
//

import SwiftUI

class EducationBlockVM: ObservableObject {
    @Published var tiles: [EducationTileVM]
    
    init(tiles: [EducationTileVM] = []) {
        self.tiles = tiles
    }
    
    func addTile() {
        tiles.append(EducationTileVM())
    }
    
    func removeTile(id: UUID) {
        tiles.removeAll { $0.id == id }
    }
    
    var isFilled: Bool {
        tiles.allSatisfy { $0.isFilled }
    }
}
