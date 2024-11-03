import UIKit

// MARK: - Model

struct TableData {
    let month: String
    var days: [BirthdayInfo]
}

// MARK: - BirthdayListViewController

final class BirthdayListViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(BirthdayTableViewCell.self, forCellReuseIdentifier: BirthdayTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    private let coreDataManager: BirthdayStorageProtocol
    
    private var data: [TableData] = []
    
    init(coreDataManager: BirthdayStorageProtocol = CoreDataStorage.shared) {
        self.coreDataManager = coreDataManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadTable()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupUI() {
        title = NSLocalizedString("birthdays_header_label", comment: "")
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func reloadTable() {
        let birthdays = coreDataManager.fetchBirthdayModels()
        self.data = groupBirthdays(birthdays)
        tableView.reloadData()
    }
    
    private func groupBirthdays(_ birthdays: [BirthdayInfo]) -> [TableData] {
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MMMM"
        
        let groupedByMonth = Dictionary(grouping: birthdays) { birthday -> String in
            return monthFormatter.string(from: birthday.birthday)
        }
        
        var tableDataArray: [TableData] = []
        
        for (month, monthBirthdays) in groupedByMonth {
            let sortedBirthdays = monthBirthdays.sorted {
                let day1 = Calendar.current.component(.day, from: $0.birthday)
                let day2 = Calendar.current.component(.day, from: $1.birthday)
                return day1 < day2
            }
            tableDataArray.append(TableData(month: month, days: sortedBirthdays))
        }
        
        tableDataArray.sort { (data1, data2) -> Bool in
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM"
            
            guard let date1 = formatter.date(from: data1.month),
                  let date2 = formatter.date(from: data2.month)
            else { return false }
            
            return date1 < date2
        }
        
        return tableDataArray
    }
}

// MARK: - UITableView Delegate and DataSource

extension BirthdayListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BirthdayTableViewCell.reuseIdentifier, for: indexPath) as? BirthdayTableViewCell else {
            return UITableViewCell()
        }
        
        let birthdayInfo = data[indexPath.section].days[indexPath.row]
        cell.configure(with: birthdayInfo)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return data[section].month
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let openBirthdayID = data[indexPath.section].days[indexPath.row].id
        let vc = BirthdayInfoViewController(.edit(openBirthdayID)) { [weak self] in
            self?.dismiss(animated: true)
            self?.reloadTable()
        }
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deletedBirthdayID = data[indexPath.section].days[indexPath.row].id
            
            data[indexPath.section].days.remove(at: indexPath.row)
            
            if data[indexPath.section].days.isEmpty {
                data.remove(at: indexPath.section)
                tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
            } else {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            coreDataManager.deleteBirthday(by: deletedBirthdayID)
        }
    }
}
