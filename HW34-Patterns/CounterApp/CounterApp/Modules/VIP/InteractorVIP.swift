import Foundation

// MARK: - InteractorProtocol

protocol InteractorVIPProtocol: AnyObject {
    func initialise()
    func incrementCount()
    func decrementCount()
}

// MARK: - InteractorOutputProtocol

protocol InteractorOutputVIPProtocol: AnyObject {
    func countDidChange(to count: Int)
    func incrementButtonStateDidChange(to isEnabled: Bool)
    func decrementButtonStateDidChange(to isEnabled: Bool)
}

// MARK: - Interactor

final class InteractorVIP: InteractorVIPProtocol {
    weak var presenter: InteractorOutputVIPProtocol?
    private var entity: EntityVIP
    
    init(
        presenter: InteractorOutputVIPProtocol?,
        entity: EntityVIP
    ) {
        self.presenter = presenter
        self.entity = entity
    }
    
    func initialise() {
        presenter?.countDidChange(to: entity.count)
        presenter?.decrementButtonStateDidChange(to: entity.count < 50)
        presenter?.decrementButtonStateDidChange(to: entity.count > 0)
    }
    
    func incrementCount() {
        entity.count += 1
        presenter?.countDidChange(to: entity.count)
        presenter?.decrementButtonStateDidChange(to: entity.count < 50)
    }
    
    func decrementCount() {
        entity.count -= 1
        presenter?.countDidChange(to: entity.count)
        presenter?.decrementButtonStateDidChange(to: entity.count > 0)
    }
}
