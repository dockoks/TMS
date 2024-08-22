import UIKit

final class ViewController: UIViewController {
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter text"
        textField.autocorrectionType = .no
        textField.tintColor = .systemRed
        textField.returnKeyType = .send
        return textField
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium, width: .standard)
        button.setTitle("Show text", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        return button
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Your text will be displayed here"
        label.font = .systemFont(ofSize: 20, weight: .regular, width: .standard)
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(textField)
        view.addSubview(button)
        view.addSubview(label)
        
        textField.delegate = self
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        setupConstraints()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    private func setupConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -20),
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            textField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            textField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])
    }
    
    @objc 
    private func buttonTapped() {
        guard let text = textField.text, !text.isEmpty else { return }
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            label.text = textField.text
            label.textColor = .label
            textField.text = ""
            textField.resignFirstResponder()
        }
    }
    
    // MARK: - Keyboard Handling
    @objc 
    private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardSize.height / 2
        }
    }

    @objc 
    private func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc 
    private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        buttonTapped()
        return true
    }
}
