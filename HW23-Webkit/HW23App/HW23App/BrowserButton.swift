import UIKit

enum ButtonStyle {
    case save
    case backward
    case forward
    case reload
    case bookmarks
    case history
}

final class BrowserButton: UIButton {
    private let style: ButtonStyle
    private let action: () -> Void
    
    init(
        style: ButtonStyle,
        action: @escaping () -> Void
    ) {
        self.style = style
        self.action = action
        super.init(frame: .zero)
        
        setupIcon()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 44),
            self.widthAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupIcon() {
        let image: UIImage?
        switch style {
        case .backward:
            image = UIImage(systemName: "chevron.backward")
        case .forward:
            image = UIImage(systemName: "chevron.forward")
        case .reload:
            image = UIImage(systemName: "arrow.clockwise")
        case .bookmarks:
            image = UIImage(systemName: "book")
        case .history:
            image = UIImage(systemName: "tray.full")
        case .save:
            image = UIImage(systemName: "bookmark")
        }
        
        self.setImage(image ?? .remove, for: .normal)
        self.tintColor = .label
    }
    
    @objc
    private func buttonDidTap() {
        UIView.animate(withDuration: 0.1, animations: {
            self.tintColor = .label.withAlphaComponent(0.5)
        }, completion: { _ in
            self.tintColor = .label
            self.action()
        })
    }
}

enum ToggleButtonStyle {
    case save
}

final class BrowserButtonToggle: UIButton {
    private let style: ToggleButtonStyle
    private let action: () -> Void
    var isOn: Bool = false {
        didSet { self.setupIcon() }
    }
    
    init(
        style: ToggleButtonStyle,
        action: @escaping () -> Void
    ) {
        self.style = style
        self.action = action
        super.init(frame: .zero)
        
        setupIcon()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 44),
            self.widthAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupIcon() {
        let image: UIImage?

        switch style {
        case .save:
            image = isOn ? UIImage(systemName: "bookmark.fill") : UIImage(systemName: "bookmark")
        }
        
        self.setImage(image ?? .remove, for: .normal)
        self.tintColor = .label
    }
    
    @objc
    private func buttonDidTap() {
        UIView.animate(withDuration: 0.1, animations: {
            self.tintColor = .label.withAlphaComponent(0.5)
        }, completion: { _ in
            self.tintColor = .label
            self.action()
        })
    }
}
