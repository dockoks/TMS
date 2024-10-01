import UIKit

class UsersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private var users: [UserDTO] = []
    private let tableView = UITableView()
    private let loaderView = UIActivityIndicatorView(style: .large)
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemBackground
        title = "Users"
        
        setupView()
        fetchUsers()
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension

    }
    
    private func setupView() {
        tableView.frame = view.bounds
        tableView.backgroundColor = .secondarySystemBackground
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.isHidden = true
        view.addSubview(tableView)
        
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loaderView)
        NSLayoutConstraint.activate([
            loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        loaderView.startAnimating()
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc private func refreshData() {
        fetchUsers(isRefreshing: true)
    }
    
    private func fetchUsers(isRefreshing: Bool = false) {
        NetworkManager.shared.fetchUsers { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(let users):
                    self.users = users
                    self.tableView.reloadData()
                    
                    if isRefreshing {
                        self.refreshControl.endRefreshing()
                    } else {
                        self.loaderView.stopAnimating()
                        self.loaderView.isHidden = true
                        self.tableView.isHidden = false
                    }
                    
                case .failure(let error):
                    print("Failed to fetch users with error: \(error)")
                    
                    if isRefreshing {
                        self.refreshControl.endRefreshing()
                    } else {
                        self.loaderView.stopAnimating()
                        self.loaderView.isHidden = true
                        self.tableView.isHidden = true
                    }
                }
            }
        }
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.reuseIdentifier, for: indexPath) as? UserTableViewCell else {
            return UITableViewCell(frame: .zero)
        }
        let user = users[indexPath.row]
        cell.configure(with: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let vc = UserDetailViewController(user: user)
        present(vc, animated: true)
    }
}
