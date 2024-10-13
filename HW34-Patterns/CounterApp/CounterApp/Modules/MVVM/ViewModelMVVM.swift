import Foundation

import Foundation

final class ViewModelMVVM {
    var counterValue: Bindable<Int> = .init()
    var isIncrementEnabled: Bool {
        guard let value = counterValue.value else { return false }
        return value < 50
    }
    var isDecrementEnabled: Bool {
        guard let value = counterValue.value else { return false }
        return value > 0
    }
    
    init() {}
    
    func initialise() {
        self.counterValue.value = 0
    }
    
    func increment() {
        guard let value = counterValue.value else { return }
        self.counterValue.value = value + 1
    }
    
    func decrement() {
        guard let value = counterValue.value else { return }
        self.counterValue.value = value - 1
    }
}
