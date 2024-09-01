import UIKit

struct Cell {
    let title: String
    let value: () -> String?
}

enum ProfileSection: Int, CaseIterable {
    case general
    case interests
    
    var title: String {
        switch self {
        case .general:
            return "General"
        case .interests:
            return "Interests"
        }
    }
    
    var cells: [Cell] {
        switch self {
        case .general:
            return [
                Cell(title: "Name") { ProfileModel.shared.stringValue(for: .name) },
                Cell(title: "Surname") { ProfileModel.shared.stringValue(for: .surname) },
                Cell(title: "Age") { ProfileModel.shared.stringValue(for: .age) },
                Cell(title: "Sex") { ProfileModel.shared.stringValue(for: .sex) },
                Cell(title: "Birthday") { ProfileModel.shared.stringValue(for: .birthday) }
            ]
        case .interests:
            return [
                Cell(title: "Interests", value: { ProfileModel.shared.stringValue(for: .interests) })
            ]
        }
    }
}

final class ProfileViewController: UIViewController {
    private var profile = ProfileModel.shared
    private let tableView: UITableView
    
    init(style: UITableView.Style = .insetGrouped) {
        self.tableView = UITableView(frame: .zero, style: style)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupTableView()
        profile.delegate = self
    }
    
    private func setupViewController() {
        self.title = "Profile"
        self.view.backgroundColor = .secondarySystemBackground
    }
    
    private func setupTableView() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.reuseIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifiers.interestCell)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc func editProfileField(_ sender: UIButton) {
        guard let cell = sender.superview?.superview as? ProfileTableViewCell,
              let indexPath = tableView.indexPath(for: cell),
              let profileSection = ProfileSection(rawValue: indexPath.section) else { return }
        
        switch profileSection {
        case .general:
            let propertyKey: PropertyKey
            let propertyValue: Any?
            let propertyType: PropertyType
            
            switch indexPath.row {
            case 0:
                propertyKey = .name
                propertyValue = profile.name
                propertyType = .text
            case 1:
                propertyKey = .surname
                propertyValue = profile.surname
                propertyType = .text
            case 2:
                propertyKey = .age
                propertyValue = profile.age
                propertyType = .number
            case 3:
                propertyKey = .sex
                propertyValue = profile.sex?.rawValue
                propertyType = .segmented
            case 4:
                propertyKey = .birthday
                propertyValue = profile.birthday
                propertyType = .date
            default:
                return
            }
            
            let editVC = EditPropertyViewController(
                propertyKey: propertyKey,
                propertyValue: propertyValue,
                propertyType: propertyType
            )
            editVC.delegate = self
            navigationController?.pushViewController(editVC, animated: true)
            
        case .interests:
            let interestVC = InterestViewController(interests: profile.interests ?? [])
            interestVC.delegate = self
            navigationController?.pushViewController(interestVC, animated: true)
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ProfileSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let profileSection = ProfileSection(rawValue: section) else { return nil }
        return profileSection.title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let profileSection = ProfileSection(rawValue: section) else { return 0 }
        return profileSection.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let profileSection = ProfileSection(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        let cellData = profileSection.cells[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.reuseIdentifier, for: indexPath) as? ProfileTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: cellData.title, value: cellData.value())
        cell.editButton.addTarget(self, action: #selector(editProfileField(_:)), for: .touchUpInside)
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {}

extension ProfileViewController: ProfileModelDelegate {
    func didUpdateProfile() {
        tableView.reloadData()
    }
}

extension ProfileViewController: InterestViewControllerDelegate {
    func didUpdateInterests(_ interests: [String]) {
        profile.interests = interests
    }
}

extension ProfileViewController: EditPropertyViewControllerDelegate {
    func didSaveProperty(key: PropertyKey, value: Any?) {
        profile.update(propertyKey: key, value: value)
    }
}

private enum CellIdentifiers {
    static let interestCell = "InterestCell"
}
