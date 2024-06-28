import UIKit

class RegistrationScreenViewController: UIViewController {
    private let bgImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "registrationScreen")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Registration form"
        label.font = .systemFont(ofSize: 32)
        label.textColor = .systemBackground
        return label
    }()
    
    private let usernameLabel = UILabel()
    private let passwordLabel = UILabel()
    private let confirmationLabel = UILabel()
    
    private let usernameTextField = InsetTextField()
    private let passwordTextField = InsetTextField()
    private let confirmationTextField = InsetTextField()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.filled()
            config.title = "Save"
            config.baseForegroundColor = .label
            config.baseBackgroundColor = .systemBackground
            config.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 48, bottom: 8, trailing: 48)
            config.background.cornerRadius = 0
            button.configuration = config
        } else {
            button.setTitle("Save", for: .normal)
            button.setTitleColor(.label, for: .normal)
            button.backgroundColor = .systemBackground
            button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 48, bottom: 8, right: 48)
        }
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Setup view
    private func setupView() {
        setupBackground()
        setupHeader()
        setupBlocksView(
            makeLabelTextFieldView(
                label: usernameLabel,
                labelText: "Username",
                textField: usernameTextField,
                placeholder: "Please enter username"
            ),
            makeLabelTextFieldView(
                label: passwordLabel,
                labelText: "Password",
                textField: passwordTextField,
                placeholder: "Please enter passform"
            ),
            makeLabelTextFieldView(
                label: confirmationLabel,
                labelText: "Confirm password",
                textField: confirmationTextField,
                placeholder: "Please confirm password"
            )
        )
        setupSaveButton()
    }
    
    private func setupBackground() {
        view.addSubview(bgImageView)
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bgImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            bgImageView.topAnchor.constraint(equalTo: view.topAnchor),
            bgImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            bgImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupHeader() {
        view.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 36),
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 36)
        ])
    }
    
    private func setupBlocksView(_ views: UIView...) {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .leading
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 36),
            stackView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 40),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -36)
        ])
    }
    
    private func setupSaveButton() {
        view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: confirmationTextField.bottomAnchor, constant: 80),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - Views creation
    private func makeLabelTextFieldView(
        label: UILabel,
        labelText: String,
        textField: UITextField,
        placeholder: String
    ) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [label, textField])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        
        label.text = labelText
        label.textColor = .systemBackground
        label.font = .systemFont(ofSize: 17)
        
        textField.placeholder = placeholder
        textField.font = .systemFont(ofSize: 14)
        textField.backgroundColor = .systemBackground
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.widthAnchor.constraint(equalToConstant: view.bounds.width-72),
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])
        return stackView
    }
}
