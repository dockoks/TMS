import UIKit

struct Cell {
    let title: String
    let action: () -> Void
    var image: UIImage? = nil
}

struct Section {
    let title: String
    var cells: [Cell]
}

final class ViewController: UIViewController {

    // MARK: - UI Elements
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    // MARK: - Data
    private var sections = [Section]()
    private var selectedCity: String?
    private var selectedImage: UIImage?
    private var alertMessage: String?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        configureSections()
    }

    // MARK: - Configuration
    private func configureViewController() {
        view.backgroundColor = .white
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)

        // Set up layout constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func configureSections() {
        sections = [
            Section(
                title: "Alert",
                cells: [
                    Cell(
                        title: alertMessage ?? "Показать сообщение",
                        action: { [weak self] in
                            self?.presentAlertController()
                        }
                    )
                ]
            ),
            Section(
                title: "Picker",
                cells: [
                    Cell(
                        title: selectedCity ?? "Выберите город",
                        action: { [weak self] in
                            self?.presentCityPicker()
                        }
                    )
                ]
            ),
            Section(
                title: "Image Picker",
                cells: [
                    Cell(
                        title: "Загрузить изображение",
                        action: { [weak self] in
                            self?.presentImagePicker()
                        },
                        image: selectedImage ?? nil
                    )
                ]
            )
        ]
    }

    // MARK: - Actions
    private func presentAlertController() {
        let alert = UIAlertController(
            title: "Важное сообщение",
            message: "Спасибо, что выбрали наше приложение!",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.alertMessage = "Спасибо!"
            self?.configureSections()
            self?.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)

        alert.addAction(okAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }

    private func presentCityPicker() {
        let cityPickerVC = CityPickerViewController()
        cityPickerVC.delegate = self
        cityPickerVC.modalPresentationStyle = .popover
        present(cityPickerVC, animated: true, completion: nil)
    }

    private func presentImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellConfig = sections[indexPath.section].cells[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = cellConfig.title
        cell.selectionStyle = .none
        cell.imageView?.image = cellConfig.image
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellConfig = sections[indexPath.section].cells[indexPath.row]
        cellConfig.action()
    }
}

// MARK: - CityPickerViewControllerDelegate
extension ViewController: CityPickerViewControllerDelegate {

    func cityPickerViewController(_ controller: CityPickerViewController, didSelectCity city: String) {
        selectedCity = city
        configureSections()
        tableView.reloadData()
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        if let image = info[.originalImage] as? UIImage {
            selectedImage = image
        }
        dismiss(animated: true) {
            self.configureSections()
            self.tableView.reloadData()
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
