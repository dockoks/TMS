import UIKit

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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "InterestCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc func editProfileField(_ sender: UIButton) {
        guard let cell = sender.superview?.superview as? ProfileTableViewCell else { return }
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        var propertyKey: PropertyKey
        var propertyValue: Any?
        var propertyType: PropertyType
        
        switch indexPath.section {
        case 0:
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
        case 1:
            let interestVC = InterestViewController(interests: profile.interests ?? [])
            interestVC.delegate = self
            navigationController?.pushViewController(interestVC, animated: true)
        default:
            return
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "General" : "Interests"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 5 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.reuseIdentifier, for: indexPath) as? ProfileTableViewCell else {
            return UITableViewCell()
        }
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0: cell.configure(with: "Name", value: profile.stringValue(for: .name))
            case 1: cell.configure(with: "Surname", value: profile.stringValue(for: .surname))
            case 2: cell.configure(with: "Age", value: profile.stringValue(for: .age))
            case 3: cell.configure(with: "Sex", value: profile.stringValue(for: .sex))
            case 4: cell.configure(with: "Birthday", value: profile.stringValue(for: .birthday))
            default: break
            }
            cell.editButton.addTarget(self, action: #selector(editProfileField(_:)), for: .touchUpInside)
            return cell
        } else {
            cell.configure(with: "Interests", value: profile.stringValue(for: .interests))
            cell.editButton.addTarget(self, action: #selector(editProfileField(_:)), for: .touchUpInside)
            return cell
        }
    }
}

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
