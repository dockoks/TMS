import UIKit

final class ControlView: UIView {
    private enum Constants {
        static let sideButtonHeight: CGFloat = 96
        static let interButtonInset: CGFloat = 8
    }
    
    let upAction: () -> Void
    let downAction: () -> Void
    let leftAction: () -> Void
    let rightAction: () -> Void
    
    let leftButton = DirectionButton(direction: .left)
    let rightButton = DirectionButton(direction: .right)
    let upButton = DirectionButton(direction: .up)
    let downButton = DirectionButton(direction: .down)
    
    private var actionTimer: Timer?
    
    init(
        upAction: @escaping () -> Void,
        downAction: @escaping () -> Void,
        leftAction: @escaping () -> Void,
        rightAction: @escaping () -> Void
    ) {
        self.upAction = upAction
        self.downAction = downAction
        self.leftAction = leftAction
        self.rightAction = rightAction
        super.init(frame: .zero)
        setupUI()
        setupControls()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(leftButton)
        self.addSubview(rightButton)
        self.addSubview(upButton)
        self.addSubview(downButton)
        
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        upButton.translatesAutoresizingMaskIntoConstraints = false
        downButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leftButton.leftAnchor.constraint(equalTo: self.leftAnchor),
            leftButton.heightAnchor.constraint(equalToConstant: Constants.sideButtonHeight),
            leftButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3, constant: -Constants.interButtonInset/2),
            
            rightButton.rightAnchor.constraint(equalTo: self.rightAnchor),
            rightButton.heightAnchor.constraint(equalToConstant: Constants.sideButtonHeight),
            rightButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3, constant: -Constants.interButtonInset/2),
            
            upButton.topAnchor.constraint(equalTo: self.topAnchor),
            upButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            upButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3, constant: -Constants.interButtonInset),
            upButton.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -Constants.interButtonInset/2),
            
            downButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            downButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            downButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3, constant: -Constants.interButtonInset),
            downButton.topAnchor.constraint(equalTo: self.centerYAnchor, constant: Constants.interButtonInset/2),
            
            self.heightAnchor.constraint(equalToConstant: Constants.sideButtonHeight)
        ])
    }
    
    private func setupControls() {
        upButton.addTarget(self, action: #selector(directionButtonTapped(_:)), for: .touchUpInside)
        downButton.addTarget(self, action: #selector(directionButtonTapped(_:)), for: .touchUpInside)
        leftButton.addTarget(self, action: #selector(directionButtonTapped(_:)), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(directionButtonTapped(_:)), for: .touchUpInside)
        
        addLongPressGesture(to: upButton, action: #selector(didLongPressButton(_:)))
        addLongPressGesture(to: downButton, action: #selector(didLongPressButton(_:)))
        addLongPressGesture(to: leftButton, action: #selector(didLongPressButton(_:)))
        addLongPressGesture(to: rightButton, action: #selector(didLongPressButton(_:)))
    }
    
    private func addLongPressGesture(to button: DirectionButton, action: Selector) {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: action)
        longPressRecognizer.minimumPressDuration = 0.3
        button.addGestureRecognizer(longPressRecognizer)
    }
    
    private func triggerAction(for direction: Direction) {
        switch direction {
        case .up:
            upAction()
        case .down:
            downAction()
        case .left:
            leftAction()
        case .right:
            rightAction()
        }
    }
    
    @objc
    private func directionButtonTapped(_ sender: DirectionButton) {
        actionTimer?.invalidate()
        actionTimer = nil
        
        triggerAction(for: sender.direction)
    }
    
    @objc
    private func didLongPressButton(_ gestureRecognizer: UILongPressGestureRecognizer) {
        guard let button = gestureRecognizer.view as? DirectionButton else { return }
        
        if gestureRecognizer.state == .began {
            actionTimer?.invalidate()
            actionTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
                self?.triggerAction(for: button.direction)
            }
        } else if gestureRecognizer.state == .ended || gestureRecognizer.state == .cancelled {
            actionTimer?.invalidate()
            actionTimer = nil
        }
    }
}
