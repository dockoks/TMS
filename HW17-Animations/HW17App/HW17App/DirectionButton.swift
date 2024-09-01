import UIKit

enum Direction {
    case up
    case down
    case left
    case right
}

final class DirectionButton: UIButton {
    private enum Constants {
        static let cornerRadius: CGFloat = 8
    }
    let direction: Direction
    
    init(direction: Direction) {
        self.direction = direction
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupCorners()
    }
    
    private func setupUI() {
        let image: UIImage?
        
        switch direction {
        case .up:
            image = UIImage(systemName: "arrowshape.up.fill")
        case .down:
            image = UIImage(systemName: "arrowshape.down.fill")
        case .left:
            image = UIImage(systemName: "arrowshape.left.fill")
        case .right:
            image = UIImage(systemName: "arrowshape.right.fill")
        }
        
        self.backgroundColor = .secondarySystemFill
        self.setImage(image, for: .normal)
        self.tintColor = .secondaryLabel
    }
    
    private func setupCorners() {
        switch self.direction {

        case .up, .down:
            self.layer.cornerRadius = Constants.cornerRadius
        case .left:
            self.roundCorners(cornerRadii: [
                .topLeft : Constants.cornerRadius,
                .bottomLeft : self.frame.height/2,
                .topRight : Constants.cornerRadius,
                .bottomRight : Constants.cornerRadius
            ])
        case .right:
            self.roundCorners(cornerRadii: [
                .topRight : Constants.cornerRadius,
                .bottomRight : self.frame.height/2,
                .topLeft : Constants.cornerRadius,
                .bottomLeft : Constants.cornerRadius
            ])
        }
    }
    
}
