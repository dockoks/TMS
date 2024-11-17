//
//  UserDetailViewController.swift
//  HW29App
//
//  Created by Danila Kokin on 25/9/24.
//


import UIKit
import MapKit

final class UserDetailViewController: UIViewController {
    
    // MARK: - UI Elements
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let nameLabel = UILabel()
    private let usernameLabel = UILabel()
    private let emailLabel = UILabel()
    private let phoneLabel = UILabel()
    private let websiteLabel = UILabel()
    
    private let separator1 = UIView()
    
    private let companyNameLabel = UILabel()
    private let catchPhraseLabel = UILabel()
    private let bsLabel = UILabel()
    
    private let separator2 = UIView()
    
    private let addressLabel = UILabel()
    private let mapView = MKMapView()
    
    private var user: UserDTO?

    // MARK: - Initializer
    init(user: UserDTO) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        configureWithUserData()
    }

    // MARK: - Setup UI
    private func setupViews() {
        view.backgroundColor = .secondarySystemBackground
        title = user?.name
        
        nameLabel.font = .systemFont(ofSize: 22, weight: .bold)
        usernameLabel.font = .systemFont(ofSize: 18)
        emailLabel.font = .systemFont(ofSize: 16)
        phoneLabel.font = .systemFont(ofSize: 16)
        websiteLabel.font = .systemFont(ofSize: 16)
        
        separator1.backgroundColor = .separator

        companyNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        catchPhraseLabel.font = .italicSystemFont(ofSize: 16)
        bsLabel.font = .systemFont(ofSize: 14)
        bsLabel.textColor = .gray
        
        addressLabel.font = .systemFont(ofSize: 16)
        addressLabel.numberOfLines = 0
        
        separator2.backgroundColor = .separator
        
        mapView.layer.cornerRadius = 10
        mapView.clipsToBounds = true
        
        scrollView.addSubview(contentView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(emailLabel)
        contentView.addSubview(phoneLabel)
        contentView.addSubview(websiteLabel)
        contentView.addSubview(separator1)
        contentView.addSubview(companyNameLabel)
        contentView.addSubview(catchPhraseLabel)
        contentView.addSubview(bsLabel)
        contentView.addSubview(addressLabel)
        contentView.addSubview(separator2)
        contentView.addSubview(mapView)
        
        view.addSubview(scrollView)
    }
    
    private func setupLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        websiteLabel.translatesAutoresizingMaskIntoConstraints = false
        companyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        catchPhraseLabel.translatesAutoresizingMaskIntoConstraints = false
        bsLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        separator1.translatesAutoresizingMaskIntoConstraints = false
        separator2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            usernameLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            usernameLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            phoneLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            phoneLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            websiteLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 8),
            websiteLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            websiteLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            separator1.topAnchor.constraint(equalTo: websiteLabel.bottomAnchor, constant: 8),
            separator1.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            separator1.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            separator1.heightAnchor.constraint(equalToConstant: 1),
            
            companyNameLabel.topAnchor.constraint(equalTo: separator1.bottomAnchor, constant: 20),
            companyNameLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            companyNameLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            catchPhraseLabel.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor, constant: 4),
            catchPhraseLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            catchPhraseLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            bsLabel.topAnchor.constraint(equalTo: catchPhraseLabel.bottomAnchor, constant: 4),
            bsLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            bsLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            separator2.topAnchor.constraint(equalTo: bsLabel.bottomAnchor, constant: 8),
            separator2.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            separator2.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            separator2.heightAnchor.constraint(equalToConstant: 1),
            
            addressLabel.topAnchor.constraint(equalTo: separator2.bottomAnchor, constant: 20),
            addressLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            mapView.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 16),
            mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mapView.heightAnchor.constraint(equalToConstant: 200),
            mapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }

    // MARK: - Configure with User Data
    private func configureWithUserData() {
        guard let user = user else { return }
        
        nameLabel.text = user.name
        usernameLabel.text = "@\(user.username)"
        emailLabel.text = "Email: \(user.email)"
        phoneLabel.text = "Phone: \(user.phone)"
        websiteLabel.text = "Website: \(user.website)"
        
        companyNameLabel.text = user.company.name
        catchPhraseLabel.text = "Catch Phrase: \(user.company.catchPhrase)"
        bsLabel.text = "BS: \(user.company.bs)"
        
        addressLabel.text = "\(user.address.street), \(user.address.suite), \(user.address.city), \(user.address.zipcode)"
        
        if let latitude = Double(user.address.geo.lat), let longitude = Double(user.address.geo.lng) {
            let locationCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let region = MKCoordinateRegion(center: locationCoordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            mapView.setRegion(region, animated: false)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = locationCoordinate
            annotation.title = "\(user.address.street), \(user.address.city)"
            mapView.addAnnotation(annotation)
        }
    }
}
