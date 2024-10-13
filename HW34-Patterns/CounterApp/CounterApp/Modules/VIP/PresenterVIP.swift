import Foundation

// MARK: - PresenterProtocol

protocol PresenterVIPProtocol: AnyObject {
    func viewDidLoad()
    func incrementButtonTapped()
    func decrementButtonTapped()
}

// MARK: - PresenterOutputProtocol

protocol PresenterOutputVIPProtocol: AnyObject {
    func updateCount(to count: Int)
    func updateIncrementButtonState(isEnabled: Bool)
    func updateDecrementButtonState(isEnabled: Bool)
}

// MARK: - Presenter

final class PresenterVIP: PresenterVIPProtocol {
    weak var view: PresenterOutputVIPProtocol?
    var interactor: InteractorVIPProtocol?
    
    init(
        view: PresenterOutputVIPProtocol?,
        interactor: InteractorVIPProtocol?
    ) {
        self.view = view
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        interactor?.initialise()
    }
    
    func incrementButtonTapped() {
        interactor?.incrementCount()
    }
    
    func decrementButtonTapped() {
        interactor?.decrementCount()
    }
}

// MARK: - InteractorOutputVIPProtocol

extension PresenterVIP: InteractorOutputVIPProtocol {
    func incrementButtonStateDidChange(to isEnabled: Bool) {
        view?.updateIncrementButtonState(isEnabled: isEnabled)
    }
    
    func decrementButtonStateDidChange(to isEnabled: Bool) {
        view?.updateDecrementButtonState(isEnabled: isEnabled)
    }
    
    func countDidChange(to count: Int) {
        view?.updateCount(to: count)
    }
}
