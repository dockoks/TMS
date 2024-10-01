import UIKit
import MapKit

final class UserTableViewCell: UITableViewCell {
    static let reuseIdentifier = "userCellIdentifier"
    
    // MARK: - UI Elements
    private let wrapperView = UIView()
    private let nameIcon = UIImageView(image: UIImage(systemName: "person.circle"))
    private let companyIcon = UIImageView(image: UIImage(systemName: "building.2"))
    private let addressIcon = UIImageView(image: UIImage(systemName: "mappin.and.ellipse"))
    
    private let nameLabel = UILabel()
    private let emailLabel = UILabel()
    private let companyLabel = UILabel()
    private let addressLabel = UILabel()
    private let mapView = MKMapView()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure Cell with UserDTO
    func configure(with user: UserDTO) {
        nameLabel.text = "\(user.name)"
        companyLabel.text = "Company: \(user.company.name)"
        addressLabel.text = "\(user.address.street), \(user.address.city), \(user.address.zipcode)"
        
        guard let latitude = Double(user.address.geo.lat),
              let longitude = Double(user.address.geo.lng) else {
            mapView.isHidden = true
            return
        }
        
        let locationCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: locationCoordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: false)
        
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoordinate
        annotation.title = "\(user.address.city), \(user.address.street)"
        mapView.addAnnotation(annotation)
        
        mapView.isHidden = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
        emailLabel.text = nil
        companyLabel.text = nil
        addressLabel.text = nil
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.setRegion(MKCoordinateRegion(), animated: false)
        mapView.isHidden = true
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        self.backgroundColor = .clear
        
        wrapperView.layer.cornerRadius = 12
        wrapperView.layer.cornerCurve = .continuous
        wrapperView.backgroundColor = .systemBackground
        wrapperView.clipsToBounds = true
        
        nameIcon.tintColor = .systemGray
        companyIcon.tintColor = .systemGray
        addressIcon.tintColor = .systemGray
        
        nameLabel.numberOfLines = 1
        nameLabel.font = .systemFont(ofSize: 16, weight: .medium, width: .standard)
        
        emailLabel.font = UIFont.systemFont(ofSize: 14)
        emailLabel.textColor = .darkGray
        
        companyLabel.font = UIFont.systemFont(ofSize: 14)
        companyLabel.textColor = .darkGray
        
        addressLabel.font = UIFont.systemFont(ofSize: 14)
        addressLabel.textColor = .darkGray
        addressLabel.numberOfLines = 0
        
        mapView.layer.cornerRadius = 8
        mapView.layer.cornerCurve = .continuous
        mapView.clipsToBounds = true
        mapView.isUserInteractionEnabled = false
        
        contentView.addSubview(wrapperView)
        wrapperView.addSubview(nameIcon)
        wrapperView.addSubview(companyIcon)
        wrapperView.addSubview(addressIcon)
        wrapperView.addSubview(nameLabel)
        wrapperView.addSubview(companyLabel)
        wrapperView.addSubview(addressLabel)
        wrapperView.addSubview(mapView)
    }
    
    // MARK: - Layout
    private func setupLayout() {
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        nameIcon.translatesAutoresizingMaskIntoConstraints = false
        companyIcon.translatesAutoresizingMaskIntoConstraints = false
        addressIcon.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            wrapperView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            wrapperView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            wrapperView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            wrapperView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            nameIcon.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 10),
            nameIcon.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 10),
            nameIcon.widthAnchor.constraint(equalToConstant: 24),
            nameIcon.heightAnchor.constraint(equalToConstant: 24),
            
            nameLabel.leadingAnchor.constraint(equalTo: nameIcon.trailingAnchor, constant: 10),
            nameLabel.centerYAnchor.constraint(equalTo: nameIcon.centerYAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -10),
            
            companyIcon.topAnchor.constraint(equalTo: nameIcon.bottomAnchor, constant: 10),
            companyIcon.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 10),
            companyIcon.widthAnchor.constraint(equalToConstant: 24),
            companyIcon.heightAnchor.constraint(equalToConstant: 24),
            
            companyLabel.leadingAnchor.constraint(equalTo: companyIcon.trailingAnchor, constant: 10),
            companyLabel.centerYAnchor.constraint(equalTo: companyIcon.centerYAnchor),
            companyLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -10),
        
            addressIcon.topAnchor.constraint(equalTo: companyIcon.bottomAnchor, constant: 10),
            addressIcon.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 10),
            addressIcon.widthAnchor.constraint(equalToConstant: 24),
            addressIcon.heightAnchor.constraint(equalToConstant: 24),
            
            addressLabel.leadingAnchor.constraint(equalTo: addressIcon.trailingAnchor, constant: 10),
            addressLabel.centerYAnchor.constraint(equalTo: addressIcon.centerYAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -10),
            
            mapView.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 10),
            mapView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 10),
            mapView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -10),
            mapView.heightAnchor.constraint(equalToConstant: 150),
            mapView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -10)
        ])
    }
}
