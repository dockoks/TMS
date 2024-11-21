import UIKit

protocol CounterViewDelegate: AnyObject {
    func didTapIncrement()
    func didTapDecrement()
}

final class CounterView: UIView {
    weak var delegate: CounterViewDelegate?
    
    private let counterLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.monospacedSystemFont(ofSize: 60, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private let decrementButton: UIButton = {
        let button = UIButton()
        let imageDefault = UIImage(systemName: "minus")
        let imageDisabled = UIImage(systemName: "hand.raised")
        button.tintColor = .label
        button.setImage(imageDefault, for: .normal)
        button.setImage(imageDisabled, for: .disabled)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        button.backgroundColor = .systemFill
        button.layer.cornerRadius = 10
        button.layer.cornerCurve = .continuous
        return button
    }()
    
    private let incrementButton: UIButton = {
        let button = UIButton()
        let imageDefault = UIImage(systemName: "plus")
        let imageDisabled = UIImage(systemName: "hand.raised")
        button.tintColor = .label
        button.setImage(imageDefault, for: .normal)
        button.setImage(imageDisabled, for: .disabled)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        button.backgroundColor = .systemFill
        button.layer.cornerRadius = 10
        button.layer.cornerCurve = .continuous
        return button
    }()
    
    private let buttonsStackView: UIStackView = {
        let SV = UIStackView()
        SV.axis = .horizontal
        SV.spacing = 20
        SV.alignment = .center
        SV.distribution = .fillProportionally
        return SV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        setupLabel()
        setupButtons()
        setupConstraints()
    }
    
    private func setupLabel() {
        addSubview(counterLabel)
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupButtons() {
        buttonsStackView.addArrangedSubview(decrementButton)
        buttonsStackView.addArrangedSubview(incrementButton)
        
        incrementButton.addTarget(self, action: #selector(increaseTapped), for: .touchUpInside)
        decrementButton.addTarget(self, action: #selector(decreaseTapped), for: .touchUpInside)
        
        addSubview(buttonsStackView)
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            counterLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            counterLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -40),
            
            buttonsStackView.topAnchor.constraint(equalTo: counterLabel.bottomAnchor, constant: 20),
            buttonsStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            incrementButton.widthAnchor.constraint(equalToConstant: 40),
            incrementButton.heightAnchor.constraint(equalToConstant: 40),
            
            decrementButton.widthAnchor.constraint(equalToConstant: 40),
            decrementButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func increaseTapped() {
        delegate?.didTapIncrement()
    }
    
    @objc private func decreaseTapped() {
        delegate?.didTapDecrement()
    }
    
    func updateCount(to count: Int) {
        counterLabel.text = "\(count)"
    }
    
    func toggleIncrementButton(isEnabled: Bool) {
        incrementButton.isEnabled = isEnabled
    }
    
    func toggleDecrementButton(isEnabled: Bool) {
        decrementButton.isEnabled = isEnabled
    }
}
