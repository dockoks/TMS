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
    
    func addTile() {
        tiles.append(EducationTileVM())
    }
    
    func removeTile(by id: UUID) {
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

extension EducationBlockVM {
    func toDictionary() -> [String: Any] {
        return [
            "tiles": tiles.map { $0.toDictionary() }
        ]
    }
}
