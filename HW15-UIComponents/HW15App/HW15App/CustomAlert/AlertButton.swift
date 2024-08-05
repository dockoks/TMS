import UIKit

class CustomAlertButton: UIButton {
    enum Style {
        case primary(String)
        case secondary(String)
    }
    private var action: (() -> Void)?
    
    init(
        style: Style
    ) {
        super.init(frame: .zero)
        switch style {
        case .primary(let title):
            self.setTitle(title, for: .normal)
            self.setTitleColor(.white, for: .normal)
            self.backgroundColor = .systemBlue
            self.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        case .secondary(let title):
            self.setTitle(title, for: .normal)
            self.setTitleColor(.secondaryLabel, for: .normal)
            self.backgroundColor = .systemFill
            self.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        }
        self.layer.cornerRadius = 12
        self.layer.cornerCurve = .continuous
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addAction(_ action: @escaping () -> Void) {
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.action = action
    }
    
    @objc 
    private func buttonTapped() {
        action?()
    }
}
