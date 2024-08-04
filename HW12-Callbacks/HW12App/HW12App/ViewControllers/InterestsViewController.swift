import UIKit

protocol InterestViewControllerDelegate: AnyObject {
    func didUpdateInterests(_ interests: [String])
}

class InterestViewController: UIViewController {
    weak var delegate: InterestViewControllerDelegate?
    private var interests: [String]
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    init(interests: [String]) {
        self.interests = interests
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupTableView()
        setupNavigationBar()
    }

    private func setupViewController() {
        self.title = "Edit Interests"
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
        
        tableView.register(InterestTableViewCell.self, forCellReuseIdentifier: InterestTableViewCell.reuseIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AddInterestCell")
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func setupNavigationBar() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveInterests))
        navigationItem.rightBarButtonItem = saveButton
    }

    @objc private func saveInterests() {
        delegate?.didUpdateInterests(interests)
        navigationController?.popViewController(animated: true)
    }

    @objc private func addInterest() {
        let editVC = EditPropertyViewController(propertyKey: .interests, propertyValue: nil, propertyType: .text)
        editVC.delegate = self
        navigationController?.pushViewController(editVC, animated: true)
    }

    private func editInterest(at index: Int) {
        let editVC = EditPropertyViewController(propertyKey: .interests, propertyValue: interests[index], propertyType: .text)
        editVC.delegate = self
        navigationController?.pushViewController(editVC, animated: true)
    }

    private func deleteInterest(at index: Int) {
        interests.remove(at: index)
        tableView.reloadData()
    }
}

extension InterestViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return interests.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddInterestCell", for: indexPath)
            cell.textLabel?.text = "Add Interest"
            cell.textLabel?.textAlignment = .center
            cell.backgroundColor = .systemFill
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InterestTableViewCell.reuseIdentifier, for: indexPath) as? InterestTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: interests[indexPath.row])
            cell.editButton.addTarget(self, action: #selector(editButtonTapped(_:)), for: .touchUpInside)
            cell.deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
            return cell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            addInterest()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @objc private func editButtonTapped(_ sender: UIButton) {
        guard let cell = sender.superview?.superview as? InterestTableViewCell,
              let indexPath = tableView.indexPath(for: cell) else { return }
        editInterest(at: indexPath.row)
    }

    @objc private func deleteButtonTapped(_ sender: UIButton) {
        guard let cell = sender.superview?.superview as? InterestTableViewCell,
              let indexPath = tableView.indexPath(for: cell) else { return }
        deleteInterest(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 44
        case 1:
            return 60
        default:
            return 0
        }
    }
}

extension InterestViewController: EditPropertyViewControllerDelegate {
    func didSaveProperty(key: PropertyKey, value: Any?) {
        guard key == .interests, let newInterest = value as? String else { return }
        if let indexPath = tableView.indexPathForSelectedRow {
            interests[indexPath.row] = newInterest
        } else {
            interests.append(newInterest)
        }
        tableView.reloadData()
    }
}
