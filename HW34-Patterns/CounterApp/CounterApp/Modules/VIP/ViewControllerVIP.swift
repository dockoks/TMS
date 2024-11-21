import UIKit

class ViewControllerVIP: UIViewController {
    var presenter: PresenterVIPProtocol?
    
    private let counterView = CounterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemIndigo.withAlphaComponent(0.2)
        
        setupCounterView()
    }
    
    private func setupCounterView() {
        counterView.delegate = self
        counterView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(counterView)
        
        NSLayoutConstraint.activate([
            counterView.topAnchor.constraint(equalTo: view.topAnchor),
            counterView.leftAnchor.constraint(equalTo: view.leftAnchor),
            counterView.rightAnchor.constraint(equalTo: view.rightAnchor),
            counterView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        presenter?.viewDidLoad()
    }
}

extension ViewControllerVIP: PresenterOutputVIPProtocol {
    func updateCount(to count: Int) {
        counterView.updateCount(to: count)
    }
    
    func updateIncrementButtonState(isEnabled: Bool) {
        counterView.toggleIncrementButton(isEnabled: isEnabled)
    }
    
    func updateDecrementButtonState(isEnabled: Bool) {
        counterView.toggleDecrementButton(isEnabled: isEnabled)
    }
}

// MARK: - CounterViewDelegate

extension ViewControllerVIP: CounterViewDelegate {
    func didTapIncrement() {
        presenter?.incrementButtonTapped()
    }
    
    func didTapDecrement() {
        presenter?.decrementButtonTapped()
    }
}
