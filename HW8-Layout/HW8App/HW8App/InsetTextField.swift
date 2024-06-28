import UIKit

class InsetTextField: UITextField {
    private var textInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        layer.cornerRadius = 4
        layer.cornerCurve = .continuous
        layer.masksToBounds = true
    }
}

