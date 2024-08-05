import UIKit

class CustomAlert: UIViewController {
    private enum Constants {
        static let alertPadding: CGFloat = 12
        static let verticalSpacing: CGFloat = 12
        static let interButtonSpacing: CGFloat = 8
        static let buttonHeight: CGFloat = 44
    }
    
    private let titleString: String
    private let messageString: String?
    
    private let alertView = UIView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let leftButton: CustomAlertButton
    private let rightButton: CustomAlertButton
    
    init(
        title: String,
        message: String?,
        leftButtonStyle: CustomAlertButton.Style,
        rightButtonStyle: CustomAlertButton.Style
    ) {
        self.titleString = title
        self.messageString = message
        self.leftButton = CustomAlertButton(style: leftButtonStyle)
        self.rightButton = CustomAlertButton(style: rightButtonStyle)
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAlertView()
    }
    
    private func setupAlertView() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.addSubview(alertView)
        
        alertView.backgroundColor = .secondarySystemBackground
        alertView.layer.cornerRadius = 20
        alertView.layer.cornerCurve = .continuous
        alertView.clipsToBounds = true
        
        titleLabel.text = titleString
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .label
        titleLabel.textAlignment = .center
        
        if let messageString = messageString, !messageString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            messageLabel.text = messageString
            messageLabel.numberOfLines = 0
            messageLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            messageLabel.textColor = .secondaryLabel
            messageLabel.textAlignment = .center
            alertView.addSubview(messageLabel)
        }
        
        alertView.addSubview(titleLabel)
        alertView.addSubview(leftButton)
        alertView.addSubview(rightButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        alertView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertView.widthAnchor.constraint(equalToConstant: 320),
            
            titleLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: Constants.alertPadding),
            titleLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: Constants.alertPadding),
            titleLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -Constants.alertPadding),
        ])
        
        if let messageString = messageString, !messageString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.verticalSpacing),
                messageLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: Constants.alertPadding),
                messageLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -Constants.alertPadding),
                
                leftButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: Constants.verticalSpacing),
                leftButton.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: Constants.alertPadding),
                leftButton.trailingAnchor.constraint(equalTo: alertView.centerXAnchor, constant: -Constants.interButtonSpacing / 2),
                leftButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
                
                rightButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: Constants.verticalSpacing),
                rightButton.leadingAnchor.constraint(equalTo: alertView.centerXAnchor, constant: Constants.interButtonSpacing / 2),
                rightButton.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -Constants.alertPadding),
                rightButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
                rightButton.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -Constants.alertPadding)
            ])
        } else {
            NSLayoutConstraint.activate([
                leftButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.verticalSpacing),
                leftButton.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: Constants.alertPadding),
                leftButton.trailingAnchor.constraint(equalTo: alertView.centerXAnchor, constant: -Constants.interButtonSpacing / 2),
                leftButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
                
                rightButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.verticalSpacing),
                rightButton.leadingAnchor.constraint(equalTo: alertView.centerXAnchor, constant: Constants.interButtonSpacing / 2),
                rightButton.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -Constants.alertPadding),
                rightButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
                rightButton.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -Constants.alertPadding)
            ])
        }
    }
    
    func addPrimaryAction(action: @escaping () -> Void) {
        rightButton.addAction {
            action()
            self.dismissAlert()
        }
    }
    
    func addSecondaryAction(action: @escaping () -> Void) {
        leftButton.addAction {
            action()
            self.dismissAlert()
        }
    }
    
    @objc
    private func dismissAlert() {
        self.dismiss(animated: true, completion: nil)
    }
}
