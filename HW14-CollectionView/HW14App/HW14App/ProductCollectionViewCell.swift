import UIKit

final class ProductCollectionViewCell: UICollectionViewCell {
    private enum Constants {
        static let cornerRadius: CGFloat = 12
    }
    
    static let identifier = "ProductCollectionViewCell"
    
    private let iconWrapperView = UIView()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let modelLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private let stepper: UIStepper = {
       let stepper = UIStepper()
        return stepper
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(iconWrapperView)
        contentView.addSubview(modelLabel)
        contentView.addSubview(stepper)
        iconWrapperView.addSubview(iconImageView)
        
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerCurve = .continuous
        contentView.layer.cornerRadius = Constants.cornerRadius
        contentView.clipsToBounds = true
        
        iconWrapperView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        modelLabel.translatesAutoresizingMaskIntoConstraints = false
        stepper.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalTo: iconWrapperView.heightAnchor, multiplier: 0.5),
            iconImageView.widthAnchor.constraint(equalTo: iconWrapperView.heightAnchor, multiplier: 0.5),
            iconImageView.centerXAnchor.constraint(equalTo: iconWrapperView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconWrapperView.centerYAnchor),
            
            iconWrapperView.topAnchor.constraint(equalTo: contentView.topAnchor),
            iconWrapperView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            iconWrapperView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            iconWrapperView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            
            modelLabel.bottomAnchor.constraint(equalTo: stepper.topAnchor, constant: -10),
            modelLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            modelLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            stepper.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            stepper.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: ProductItem) {
        iconImageView.image = item.icon
        modelLabel.text = item.model
        iconImageView.tintColor = item.color
        iconWrapperView.backgroundColor = item.color.withAlphaComponent(0.1)
    }
}
