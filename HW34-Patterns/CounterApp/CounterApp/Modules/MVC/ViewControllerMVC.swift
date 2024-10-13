import UIKit

final class ViewControllerMVC: UIViewController {
    
    private let counterView = CounterView()
    private let model: ModelMVC
    
    init(model: ModelMVC) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink.withAlphaComponent(0.2)
        self.title = "MVC"
        
        counterView.delegate = self
        counterView.translatesAutoresizingMaskIntoConstraints = false
        counterView.isUserInteractionEnabled = true
        view.addSubview(counterView)
        
        NSLayoutConstraint.activate([
            counterView.topAnchor.constraint(equalTo: view.topAnchor),
            counterView.leftAnchor.constraint(equalTo: view.leftAnchor),
            counterView.rightAnchor.constraint(equalTo: view.rightAnchor),
            counterView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        setup()
    }
    
    private func setup() {
        counterView.updateCount(to: model.count)
        counterView.toggleIncrementButton(isEnabled: model.count < 50)
        counterView.toggleDecrementButton(isEnabled: model.count > 0)
    }
    
    static func instaciate() -> ViewControllerMVC {
        let model = ModelMVC()
        return ViewControllerMVC(model: model)
    }
    
    private func handleIncrement() {
        let newCount = model.increment()
        counterView.toggleIncrementButton(isEnabled: newCount < 50)
        counterView.toggleDecrementButton(isEnabled: newCount > 0)
        counterView.updateCount(to: newCount)
    }
    
    private func handleDecrement() {
        let newCount = model.decrement()
        counterView.toggleIncrementButton(isEnabled: newCount < 50)
        counterView.toggleDecrementButton(isEnabled: newCount > 0)
        counterView.updateCount(to: newCount)
    }
}

// MARK: - CounterViewDelegate

extension ViewControllerMVC: CounterViewDelegate {
    func didTapIncrement() {
        handleIncrement()
    }

    func didTapDecrement() {
        handleDecrement()
    }
}
