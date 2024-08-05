import UIKit

extension UIView {
    func applyShadow(
        color: UIColor,
        alpha: Float = 0.7,
        x: CGFloat = 0,
        y: CGFloat = 0,
        blur: CGFloat = 22,
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
