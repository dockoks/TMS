import UIKit

class AttributeButtonView: UIView {
    
    private let button: UIButton = UIButton()
    private var action: (() -> Void)?

    init(icon: UIImage, action: @escaping () -> Void) {
        super.init(frame: .zero)
        self.action = action
        setupButton(icon: icon)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupButton(icon: UIImage) {
        button.setImage(icon, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = 8
        self.layer.cornerCurve = .continuous
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.04
        self.layer.shadowOffset = .init(width: 0, height: 4)
        self.layer.shadowRadius = 4
        
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            self.heightAnchor.constraint(equalToConstant: 44),
            self.widthAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc 
    private func buttonTapped() {
        action?()
    }
}
