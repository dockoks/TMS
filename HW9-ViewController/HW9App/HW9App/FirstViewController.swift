import UIKit

class FirstViewController: UIViewController {
    private var counter: Int = 0
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Go deeper", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 12
        button.layer.cornerCurve = .continuous
        button.layer.masksToBounds = true
        return button
    }()
    private let counterlabel: UILabel = {
        let label = UILabel()
        label.font = .monospacedDigitSystemFont(ofSize: 196, weight: .medium)
        label.textColor = .tertiaryLabel
        return label
    }()
    
    init(counter: Int) {
        self.counter = counter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    

    private func setupView() {
        view.backgroundColor = .secondarySystemBackground
        setupNavigationBar()
        setupCounterLabel()
        setupButton()
    }
    
    private func setupNavigationBar() {
        if let viewControllers = navigationController?.viewControllers, viewControllers.count > 1 {
            let backButton = UIBarButtonItem(
                image: UIImage(systemName: "chevron.backward"),
                style: .done,
                target: self,
                action: #selector(closeController)
            )
            backButton.tintColor = .label
            let clearAllButton = UIBarButtonItem(
                image: UIImage(systemName: "chevron.backward.2"),
                style: .done,
                target: self,
                action: #selector(closeAllControllers)
            )
            clearAllButton.tintColor = .label
            navigationItem.rightBarButtonItem = clearAllButton
            navigationItem.leftBarButtonItem = backButton
        }
    }
    
    private func setupCounterLabel() {
        counterlabel.text = "\(counter)"
        view.addSubview(counterlabel)
        counterlabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            counterlabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            counterlabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -24)
        ])
    }
    
    private func setupButton() {
        view.addSubview(nextButton)
        nextButton.addTarget(self, action: #selector(presentNextController), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.heightAnchor.constraint(equalToConstant: 48),
            nextButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-36),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.topAnchor.constraint(equalTo: counterlabel.bottomAnchor, constant: 24)
        ])
    }
    
    @objc
    private func presentNextController() {
        let nextVC = FirstViewController(counter: self.counter + 1)
        nextVC.title = "Level \(navigationController?.viewControllers.count ?? 0 + 1)"
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc
    private func closeController() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func closeAllControllers() {
        navigationController?.popToRootViewController(animated: true)
    }
}
