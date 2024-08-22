import UIKit

extension UIRectCorner: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.rawValue)
    }
    
    public static func ==(lhs: UIRectCorner, rhs: UIRectCorner) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

extension UIView {
    func roundCorners(cornerRadii: [UIRectCorner: CGFloat]) {
        let path = UIBezierPath()
        let bounds = self.bounds
        
        let topLeftRadius = cornerRadii[.topLeft] ?? 0
        let topRightRadius = cornerRadii[.topRight] ?? 0
        let bottomLeftRadius = cornerRadii[.bottomLeft] ?? 0
        let bottomRightRadius = cornerRadii[.bottomRight] ?? 0
        
        path.move(to: CGPoint(x: bounds.minX + topLeftRadius, y: bounds.minY))
        
        path.addLine(to: CGPoint(x: bounds.maxX - topRightRadius, y: bounds.minY))
        path.addQuadCurve(to: CGPoint(x: bounds.maxX, y: bounds.minY + topRightRadius), controlPoint: CGPoint(x: bounds.maxX, y: bounds.minY))
        
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY - bottomRightRadius))
        path.addQuadCurve(to: CGPoint(x: bounds.maxX - bottomRightRadius, y: bounds.maxY), controlPoint: CGPoint(x: bounds.maxX, y: bounds.maxY))
        
        path.addLine(to: CGPoint(x: bounds.minX + bottomLeftRadius, y: bounds.maxY))
        path.addQuadCurve(to: CGPoint(x: bounds.minX, y: bounds.maxY - bottomLeftRadius), controlPoint: CGPoint(x: bounds.minX, y: bounds.maxY))
        
        path.addLine(to: CGPoint(x: bounds.minX, y: bounds.minY + topLeftRadius))
        path.addQuadCurve(to: CGPoint(x: bounds.minX + topLeftRadius, y: bounds.minY), controlPoint: CGPoint(x: bounds.minX, y: bounds.minY))
        
        path.close()
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.cornerCurve = .continuous
        self.layer.mask = mask
    }
}
