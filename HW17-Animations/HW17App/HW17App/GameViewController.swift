import UIKit

final class GameViewController: UIViewController {
    private enum Constants {
        static let animationDuration: Double = 1.0
        static let circleSize: CGFloat = 60
        static let movementDelta: CGFloat = 20
    }
    
    private let circleView = UIView()
    private let boardView = UIView()
    private let effectView: UIVisualEffectView
    
    private var circleXConstraint: NSLayoutConstraint?
    private var circleYConstraint: NSLayoutConstraint?
    
    private var isAnimating = false
    private var animationDuration: TimeInterval = Constants.animationDuration
    
    private lazy var controlView = ControlView(
        upAction: self.didMoveUp,
        downAction: self.didMoveDown,
        leftAction: self.didMoveLeft,
        rightAction: self.didMoveRight
    )
    
    init() {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        self.effectView = blurEffectView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupSwipeGestures()
        startCircleColorAnimation()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layoutBoardView()
        layoutEffectView()
    }
    
    private func setupUI() {
        view.addSubview(boardView)
        boardView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(controlView)
        controlView.translatesAutoresizingMaskIntoConstraints = false
        
        boardView.addSubview(circleView)
        circleView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(effectView)
        effectView.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure circle view
        circleView.backgroundColor = .systemBlue
        circleView.layer.cornerRadius = 30 // Half of the height/width to make it a circle
        
        // Set initial size and position for the circle view
        NSLayoutConstraint.activate([
            circleView.widthAnchor.constraint(equalToConstant: 60),
            circleView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // Initial position in the center of the board
        circleXConstraint = circleView.centerXAnchor.constraint(equalTo: boardView.centerXAnchor)
        circleYConstraint = circleView.centerYAnchor.constraint(equalTo: boardView.centerYAnchor)
        
        guard let circleXConstraint, let circleYConstraint else { return }
        circleXConstraint.isActive = true
        circleYConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            boardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            boardView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
            boardView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8),
            boardView.bottomAnchor.constraint(equalTo: controlView.topAnchor, constant: -8),
            
            effectView.topAnchor.constraint(equalTo: boardView.topAnchor),
            effectView.leftAnchor.constraint(equalTo: boardView.leftAnchor),
            effectView.rightAnchor.constraint(equalTo: boardView.rightAnchor),
            effectView.bottomAnchor.constraint(equalTo: boardView.bottomAnchor),
            
            controlView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
            controlView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            controlView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func layoutBoardView() {
        boardView.roundCorners(cornerRadii: [
            .topRight : controlView.frame.height/2,
            .bottomRight : 8,
            .topLeft : controlView.frame.height/2,
            .bottomLeft : 8
        ])
        boardView.layer.cornerCurve = .continuous
        boardView.backgroundColor = .clear
    }
    
    private func layoutEffectView() {
        effectView.roundCorners(cornerRadii: [
            .topRight : controlView.frame.height/2,
            .bottomRight : 8,
            .topLeft : controlView.frame.height/2,
            .bottomLeft : 8
        ])
        effectView.layer.cornerCurve = .continuous
        effectView.clipsToBounds = true
    }
    
    private func setupSwipeGestures() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
    }
    
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .up:
            didMoveUp()
        case .down:
            didMoveDown()
        case .left:
            didMoveLeft()
        case .right:
            didMoveRight()
        default:
            break
        }
    }
    
    private func startCircleColorAnimation() {
        guard !isAnimating else { return } // Prevent multiple animations
        isAnimating = true
        animateCircleColorChange()
    }
    
    private func animateCircleColorChange() {
        let colors: [UIColor] = [.systemRed, .systemBlue, .systemYellow, .systemPink, .systemIndigo, .systemTeal]
        let nextColor = colors.randomElement() ?? .systemRed
        
        UIView.animate(
            withDuration: animationDuration,
            delay: 0,
            options: [.allowUserInteraction, .curveLinear],
            animations: {
                self.circleView.backgroundColor = nextColor
            }, completion: { _ in
                if self.isAnimating {
                    self.animateCircleColorChange()
                }
            }
        )
    }
    
    private func stopCircleColorAnimation() {
        isAnimating = false
    }
    
    private func moveCircle(dx: CGFloat, dy: CGFloat) {
        let circleRadius: CGFloat = Constants.circleSize/2
        let boardWidth = boardView.bounds.width
        let boardHeight = boardView.bounds.height
        
        guard let circleXConstraint, let circleYConstraint else { return }
        let newCenterX = circleXConstraint.constant + dx
        let newCenterY = circleYConstraint.constant + dy
        
        let minX = -boardWidth / 2 + circleRadius
        let maxX = boardWidth / 2 - circleRadius
        let minY = -boardHeight / 2 + circleRadius
        let maxY = boardHeight / 2 - circleRadius
        
        guard
            newCenterX >= minX && newCenterX <= maxX,
            newCenterY >= minY && newCenterY <= maxY
        else { return }
        
        circleXConstraint.constant = newCenterX
        circleYConstraint.constant = newCenterY
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func didMoveUp() {
        moveCircle(dx: 0, dy: -Constants.movementDelta)
    }
    
    private func didMoveDown() {
        moveCircle(dx: 0, dy: Constants.movementDelta)
    }
    
    private func didMoveLeft() {
        moveCircle(dx: -Constants.movementDelta, dy: 0)
    }
    
    private func didMoveRight() {
        moveCircle(dx: Constants.movementDelta, dy: 0)
    }
}
