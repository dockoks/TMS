import Foundation

final class ModelMVC {
    private(set) var count: Int = 0

    func increment() -> Int {
        count += 1
        return count
    }

    func decrement() -> Int {
        count -= 1
        return count
    }
    
    func getValue() -> Int {
        return count
    }
}
