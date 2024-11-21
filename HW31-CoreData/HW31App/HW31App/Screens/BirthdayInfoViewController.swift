import UIKit
import CoreData

enum Configutation {
    case new
    case edit(UUID)
}

final class BirthdayInfoViewController: UIViewController {
    private let configuration: Configutation
    private let coreDataStorage: BirthdayStorageProtocol
    private let notificationService: NotificationProtocol
    private let completion: () -> Void
    var id = UUID()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = NSLocalizedString("name_label", comment: "")
        tf.tintColor = .label
        return tf
    }()
    
    let surnameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = NSLocalizedString("surname_label", comment: "")
        tf.tintColor = .label
        return tf
    }()
    
    let birthdayDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -100, to: Date())
        datePicker.maximumDate = Calendar.current.date(byAdding: .day, value: 2, to: Date())
        datePicker.tintColor = .label
        return datePicker
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("save_button_title", comment: ""), for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.layer.cornerCurve = .continuous
        return button
    }()
    
    init(
        _ config: Configutation = .new,
        coreDataStorage: BirthdayStorageProtocol = CoreDataStorage.shared,
        notificationService: NotificationProtocol = NotificationService.shared,
        completion: @escaping () -> Void
    ) {
        self.configuration = config
        self.coreDataStorage = coreDataStorage
        self.notificationService = notificationService
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
        switch config {
        case .new:
            return
        case .edit(let id):
            guard let birthdayInfo = coreDataStorage.getBirthday(by: id)
            else { return }
            self.id = id
            nameTextField.text = birthdayInfo.name
            surnameTextField.text = birthdayInfo.surname
            birthdayDatePicker.date = birthdayInfo.birthday
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getPendingNotificationRequests { requests in
            requests.forEach { id in
                print("Notification unscheduled for ID: \(id.identifier) \(id.content.body)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.title = NSLocalizedString("add_header_label", comment: "")
        
        view.backgroundColor = .systemBackground
        
        setupButton()
        setupDismissKeyboardGesture()
        
        let stackView = UIStackView(arrangedSubviews: [
            nameTextField,
            surnameTextField,
            birthdayDatePicker,
            saveButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            saveButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func setupButton() {
        switch configuration {
        case .new:
            saveButton.setTitle(NSLocalizedString("save_button_title", comment: ""), for: .normal)
            saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        case .edit(_):
            saveButton.setTitle(NSLocalizedString("edit_button_title", comment: ""), for: .normal)
            saveButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        }
    }
    
    func setupDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    private func saveButtonTapped() {
        guard
            let nameText = nameTextField.text, !nameText.isEmpty,
            let surnameText = surnameTextField.text, !surnameText.isEmpty
        else { return }
        
        let birthdayInfo = BirthdayInfo(
            id: UUID(),
            name: nameText,
            surname: surnameText,
            birthday: birthdayDatePicker.date
        )
        
        coreDataStorage.addBirthday(birthdayInfo)
        notificationService.schedule(birthday: birthdayInfo)
        
        nameTextField.text = nil
        surnameTextField.text = nil
        birthdayDatePicker.date = Date()
        
        if let tabBarController = self.tabBarController {
            tabBarController.selectedIndex = 1
        }
    }
    
    @objc
    private func editButtonTapped() {
        guard
            let nameText = nameTextField.text, !nameText.isEmpty,
            let surnameText = surnameTextField.text, !surnameText.isEmpty
        else { return }
        
        let birthdayInfo = BirthdayInfo(
            id: id,
            name: nameText,
            surname: surnameText,
            birthday: birthdayDatePicker.date
        )
        
        coreDataStorage.editBirthday(birthdayInfo)
        notificationService.reschedule(birthday: birthdayInfo)
        completion()
    }
}
