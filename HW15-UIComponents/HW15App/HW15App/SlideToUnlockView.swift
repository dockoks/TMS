import UIKit

class SlideToUnlockView: UIView {
    var onUnlock: (() -> Void)?

    private let trackView = UIView()
    private let thumbView = UIView()
    private let unlockLabel = UILabel()
    private var isTouchingThumb = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    init(frame: CGRect = .zero, onUnlock: (() -> Void)?) {
        self.onUnlock = onUnlock
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        configureViews()
        setupConstraints()
    }

    private func configureViews() {
        trackView.backgroundColor = .secondarySystemFill
        trackView.layer.cornerRadius = 18
        addSubview(trackView)

        unlockLabel.text = "Swipe to unlock >>"
        unlockLabel.textColor = .tertiaryLabel
        unlockLabel.font = UIFont.systemFont(ofSize: 16)
        unlockLabel.textAlignment = .center
        addSubview(unlockLabel)

        thumbView.backgroundColor = .white
        thumbView.layer.cornerRadius = 16
        thumbView.applyShadow()
        addSubview(thumbView)
    }

    private func setupConstraints() {
        trackView.translatesAutoresizingMaskIntoConstraints = false
        thumbView.translatesAutoresizingMaskIntoConstraints = false
        unlockLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            trackView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            trackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            trackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            trackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            
            thumbView.widthAnchor.constraint(equalTo: trackView.heightAnchor, constant: -8),
            thumbView.heightAnchor.constraint(equalTo: trackView.heightAnchor, constant: -8),
            thumbView.centerYAnchor.constraint(equalTo: trackView.centerYAnchor),
            thumbView.leadingAnchor.constraint(equalTo: trackView.leadingAnchor, constant: 4),  // Initial position
            
            unlockLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            unlockLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            unlockLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        bringSubviewToFront(thumbView)
    }

    // MARK: - Touch Handling
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let touchView = touch.view else { return }
        if touchView == thumbView {
            isTouchingThumb = true
            moveThumb(with: touches)
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isTouchingThumb {
            moveThumb(with: touches)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isTouchingThumb {
            if thumbView.frame.maxX < trackView.frame.maxX - 12 {
                UIView.animate(withDuration: 0.3) {
                    self.thumbView.frame.origin.x = self.trackView.frame.minX + 4
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.thumbView.frame.origin.x = self.trackView.frame.maxX - self.thumbView.frame.width - 4
                }
                onUnlock?()
            }
            isTouchingThumb = false
        }
    }

    private func moveThumb(with touches: Set<UITouch>) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let thumbHalfWidth = thumbView.frame.width / 2
        let newPosition = max(trackView.frame.minX + 4, min(location.x - thumbHalfWidth, trackView.frame.maxX - thumbView.frame.width - 4))

        thumbView.frame.origin.x = newPosition
    }
}


extension UIView {
    func applyShadow(
        color: UIColor = .black,
        alpha: Float = 0.16,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = blur / 2
        if spread == 0 {
            layer.shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
        layer.masksToBounds = false
    }
}
