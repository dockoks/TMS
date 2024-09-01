import UIKit

final class CollectionHeaderView: UICollectionReusableView {
    
    static let identifier = "CollectionHeaderView"
    
    private let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.layer.cornerRadius = 16
        blurEffectView.layer.masksToBounds = true
        return blurEffectView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(blurEffectView)
        blurEffectView.contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            
            titleLabel.leadingAnchor.constraint(equalTo: blurEffectView.contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: blurEffectView.contentView.trailingAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: blurEffectView.contentView.centerYAnchor)
        ])
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
}
