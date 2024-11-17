import UIKit

protocol CityPickerViewControllerDelegate: AnyObject {
    func cityPickerViewController(_ controller: CityPickerViewController, didSelectCity city: String)
}

final class CityPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    weak var delegate: CityPickerViewControllerDelegate?
    
    private let cities = ["Москва", "Нью-Йорк", "Лондон", "Париж"]
    private var selectedCity: String?

    private let pickerView = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupPickerView()
        setupDoneButton()
    }

    private func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pickerView)

        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pickerView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }

    private func setupDoneButton() {
        let doneButton = UIButton(type: .system)
        doneButton.setTitle("Done", for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)

        doneButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(doneButton)

        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 20),
            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc private func doneButtonTapped() {
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        selectedCity = cities[selectedRow]
        if let selectedCity = selectedCity {
            delegate?.cityPickerViewController(self, didSelectCity: selectedCity)
        }
        dismiss(animated: true, completion: nil)
    }

    // MARK: - UIPickerViewDelegate & UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }
}
