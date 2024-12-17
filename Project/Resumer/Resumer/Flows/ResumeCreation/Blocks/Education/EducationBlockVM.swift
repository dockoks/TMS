import SwiftUI
import Combine


class EducationBlockVM: ObservableObject, Fillable {
    @Published var tiles: [EducationTileVM]
    @Published var isKeyboardShowing: Bool = false
    @Published var keyBoardHeight: CGFloat = 0
    private var cancellables = Set<AnyCancellable>()
    private let keyboardResponder = KeyboardResponder()
    
    init(tiles: [EducationTileVM] = []) {
        self.tiles = tiles
        observeKeyboard()
    }
    
    init(from model: EducationBlockModel) {
        self.tiles = model.tiles.map { EducationTileVM(from: $0) }
    }
    
    func addTile() {
        tiles.append(EducationTileVM())
    }
    
    func removeTile(by id: String) {
        tiles.removeAll { $0.id == id }
    }
    
    var isFilled: Bool {
        tiles.allSatisfy { $0.isFilled }
    }
    
    private func observeKeyboard() {
        keyboardResponder.$isKeyboardVisible
            .assign(to: &$isKeyboardShowing)
        keyboardResponder.$keyboardHeight
            .assign(to: &$keyBoardHeight)
    }
}

extension EducationBlockVM: Uploadable {
    func toDictionary() -> [String: Any] {
        return [
            "tiles": tiles.map { $0.toDictionary() }
        ]
    }
    
    func toModel() -> EducationBlockModel {
        return EducationBlockModel(from: self)
    }
}
