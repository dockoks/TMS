final class Bindable<T> {
    var value: T? {
        didSet {
            handlers.forEach { closure in
                closure(value)
            }
        }
    }
    
    private var handlers: [(T?) -> Void] = []
    
    func bind(_ handler: @escaping (T?) -> Void) {
        handlers.append(handler)
    }
}
