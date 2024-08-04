import UIKit

protocol EditPropertyViewControllerDelegate: AnyObject {
    func didSaveProperty(key: PropertyKey, value: Any?)
}

final class EditPropertyViewController: UIViewController {
    enum Constants {
        static let padding: CGFloat = 20
        static let inset: CGFloat = 12
        static let buttonCornerRadius: CGFloat = 12
    }
    
    var propertyKey: PropertyKey
    var propertyValue: Any?
    var propertyType: PropertyType

    weak var delegate: EditPropertyViewControllerDelegate?

    lazy private var textField = UITextField()
    lazy private var numberField = UITextField()
    lazy private var segmentedControl = UISegmentedControl(items: ["Male", "Female"])
    lazy private var datePicker = UIDatePicker()
    lazy private var saveButton = UIButton(type: .system)

    init(
        propertyKey: PropertyKey,
        propertyValue: Any? = nil,
        propertyType: PropertyType
    ) {
        self.propertyKey = propertyKey
        self.propertyValue = propertyValue
        self.propertyType = propertyType
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit \(propertyKey.rawValue)"
        self.view.backgroundColor = .systemBackground
        setupUI()
    }

    private func setupUI() {
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.layer.cornerCurve = .continuous
        saveButton.layer.cornerRadius = Constants.buttonCornerRadius
        saveButton.addTarget(self, action: #selector(saveProperty), for: .touchUpInside)
        
        view.addSubview(saveButton)
        NSLayoutConstraint.activate([
            saveButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding),
            saveButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding),
            saveButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        switch propertyType {
        case .text:
            textField.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(textField)
            textField.text = propertyValue as? String
            textField.placeholder = "Enter \(propertyKey.rawValue)"
            NSLayoutConstraint.activate([
                textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.padding),
                textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding),
                textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding),
                textField.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -Constants.padding)
            ])
        case .number:
            numberField.translatesAutoresizingMaskIntoConstraints = false
            numberField.keyboardType = .numberPad
            view.addSubview(numberField)
            numberField.text = propertyValue as? String
            numberField.placeholder = "Enter \(propertyKey.rawValue)"
            NSLayoutConstraint.activate([
                numberField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.padding),
                numberField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding),
                numberField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding),
                numberField.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -Constants.padding)
            ])
        case .segmented:
            segmentedControl.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(segmentedControl)
            NSLayoutConstraint.activate([
                segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.padding),
                segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding),
                segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding),
                segmentedControl.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -Constants.padding)
            ])
            if let sex = propertyValue as? String, let index = ["male", "female"].firstIndex(of: sex.lowercased()) {
                segmentedControl.selectedSegmentIndex = index
            }
        case .date:
            datePicker.translatesAutoresizingMaskIntoConstraints = false
            datePicker.datePickerMode = .date
            datePicker.preferredDatePickerStyle = .wheels
            view.addSubview(datePicker)
            if let date = propertyValue as? Date {
                datePicker.date = date
            }
            NSLayoutConstraint.activate([
                datePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.padding),
                datePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding),
                datePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding),
                datePicker.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -Constants.padding)
            ])
        }
    }

    @objc func saveProperty() {
        var updatedValue: Any?
        switch propertyType {
        case .text:
            updatedValue = textField.text
        case .number:
            updatedValue = numberField.text
        case .segmented:
            updatedValue = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)?.lowercased()
        case .date:
            updatedValue = datePicker.date
        }
        ProfileModel.shared.update(propertyKey: propertyKey, value: updatedValue)
        delegate?.didSaveProperty(key: propertyKey, value: updatedValue)
        navigationController?.popViewController(animated: true)
    }
}
