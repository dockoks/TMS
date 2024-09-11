import UIKit

final class CitiesListViewController: UIViewController {
    
    weak var delegate: CitySelectionDelegate?
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let data = RegionFactory.generateData()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Select a City"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CityCell")
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    @objc
    func updateTimes() {
        tableView.reloadData()
    }
}

extension CitiesListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "CityCell")
        let city = data[indexPath.section].cities[indexPath.row]
        cell.textLabel?.text = "\(city.icon) \(city.name): \(city.utcDifference)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return data[section].name // Region name as section title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCity = data[indexPath.section].cities[indexPath.row]
        delegate?.didSelectCity(selectedCity)
        dismiss(animated: true, completion: nil)
    }
}

