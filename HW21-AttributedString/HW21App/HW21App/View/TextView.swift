import UIKit

class TextView: UIView {

    private let label: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        addSubview(label)
        
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = 20
        self.layer.cornerCurve = .continuous
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.04
        self.layer.shadowOffset = .init(width: 0, height: 4)
        self.layer.shadowRadius = 4

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }

    func updateText(_ attributedText: NSAttributedString) {
        label.attributedText = attributedText
    }

    func getSelectedRange(from location: CGPoint) -> NSRange? {
        guard let attributedText = label.attributedText else { return nil }
        let textStorage = NSTextStorage(attributedString: attributedText)
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: label.bounds.size)
        textContainer.lineFragmentPadding = 0

        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let locationOfTouchInLabel = CGPoint(
            x: location.x - (label.bounds.width - textBoundingBox.width) / 2.0,
            y: location.y - (label.bounds.height - textBoundingBox.height) / 2.0
        )

        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInLabel, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)

        if indexOfCharacter < attributedText.length {
            return NSRange(location: indexOfCharacter, length: 1)
        } else {
            return nil
        }
    }
}
