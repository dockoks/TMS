import UIKit

final class ViewControllerMVVM: UIViewController {
    private let counterView = CounterView()
    private let viewModel: ViewModelMVVM
    
    init(viewModel: ViewModelMVVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue.withAlphaComponent(0.2)

        counterView.delegate = self
        counterView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(counterView)

        NSLayoutConstraint.activate([
            counterView.topAnchor.constraint(equalTo: view.topAnchor),
            counterView.leftAnchor.constraint(equalTo: view.leftAnchor),
            counterView.rightAnchor.constraint(equalTo: view.rightAnchor),
            counterView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        viewModel.counterValue.bind { [weak self] value in
            guard let self, let value else { return }
            self.counterView.updateCount(to: value)
            self.counterView.toggleDecrementButton(isEnabled: self.viewModel.isDecrementEnabled)
            self.counterView.toggleIncrementButton(isEnabled: self.viewModel.isIncrementEnabled)
        }
        viewModel.initialise()
    }
    
    static func instantiate() -> ViewControllerMVVM {
        let viewModel = ViewModelMVVM()
        return ViewControllerMVVM(viewModel: viewModel)
    }
}

// MARK: - CounterViewDelegate

extension ViewControllerMVVM: CounterViewDelegate {
    func didTapIncrement() {
        viewModel.increment()
        
    }

    func didTapDecrement() {
        viewModel.decrement()
        
    }
}
