//
//  LanguageBlockVM.swift
//  Resumer
//
//  Created by Danila Kokin on 12/5/24.
//

import SwiftUI

class LanguageBlockVM: ObservableObject {
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

