import UIKit

protocol CitySelectionDelegate: AnyObject {
    func didSelectCity(_ city: City)
}

final class ClockViewController: UIViewController {
    private let cityLabel = UILabel()
    private let timeLabel = RotatingLabel()
    private let hoursDifferenceLabel = UILabel()
    private let openCitiesButton = UIButton(type: .system)
    
    var timer: Timer?
    var currentCity: City = City(icon: "🏙", name: "Local", utcDifference: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateTime(animated: true)
        startUpdatingTime()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        cityLabel.font = UIFont.monospacedSystemFont(ofSize: 24, weight: .medium)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        hoursDifferenceLabel.font = UIFont.monospacedSystemFont(ofSize: 16, weight: .regular)
        hoursDifferenceLabel.translatesAutoresizingMaskIntoConstraints = false
        hoursDifferenceLabel.textColor = .secondaryLabel
        
        guard let customFont = UIFont(name: "Michroma-Regular", size: 54) else { return }
        timeLabel.font = customFont
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        openCitiesButton.setTitle("Cities List", for: .normal)
        openCitiesButton.titleLabel?.font = UIFont.monospacedSystemFont(ofSize: 16, weight: .regular)
        openCitiesButton.addTarget(self, action: #selector(openCitiesList), for: .touchUpInside)
        openCitiesButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(hoursDifferenceLabel)
        view.addSubview(cityLabel)
        view.addSubview(timeLabel)
        view.addSubview(openCitiesButton)
        
        NSLayoutConstraint.activate([
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityLabel.bottomAnchor.constraint(equalTo: hoursDifferenceLabel.topAnchor, constant: -8),
            
            hoursDifferenceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            hoursDifferenceLabel.bottomAnchor.constraint(equalTo: timeLabel.topAnchor, constant: -20),
            
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            
            openCitiesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            openCitiesButton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 40)
        ])
    }
    
    private func startUpdatingTime() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimeForTimer), userInfo: nil, repeats: true)
    }

    @objc 
    private func updateTimeForTimer() {
        updateTime(animated: true)
    }
    
    private func updateTime(animated: Bool) {
        let newTime = currentCity.currentLocalTime()
        
        timeLabel.setText(newTime, animated: animated)
        cityLabel.text = "\(currentCity.icon) \(currentCity.name)"
        hoursDifferenceLabel.text = currentCity.utcDifference >= 0 ? "+\(currentCity.utcDifference)HRS" : "\(currentCity.utcDifference)HRS"
    }
    
    @objc private func openCitiesList() {
        let citiesListVC = CitiesListViewController()
        citiesListVC.delegate = self
        let navigationController = UINavigationController(rootViewController: citiesListVC)
        present(navigationController, animated: true, completion: nil)
    }
    
    deinit {
        timer?.invalidate()
    }
}

extension ClockViewController: CitySelectionDelegate {
    func didSelectCity(_ city: City) {
        currentCity = city
        updateTime(animated: false)
    }
}
