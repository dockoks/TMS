import UIKit

class InterestTableViewCell: UITableViewCell {
    static let reuseIdentifier: String = "InterestTableViewCellIdentifier"
    
    private enum Constants {
        static let padding: CGFloat = 12
        static let inset: CGFloat = 4
        static let buttonSize: CGFloat = 44
        static let buttonCornerRadius: CGFloat = 12
    }
    
    let interestLabel = UILabel()
    let editButton = UIButton(type: .system)
    let deleteButton = UIButton(type: .system)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        interestLabel.translatesAutoresizingMaskIntoConstraints = false
        editButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false

        interestLabel.numberOfLines = 1
        
        contentView.addSubview(interestLabel)
        contentView.addSubview(editButton)
        contentView.addSubview(deleteButton)

        NSLayoutConstraint.activate([
            interestLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
            interestLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.padding),
            interestLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.padding),
            interestLabel.trailingAnchor.constraint(greaterThanOrEqualTo: editButton.leadingAnchor, constant: -Constants.inset),
            
            editButton.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -Constants.inset),
            editButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            editButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            editButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
            deleteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            deleteButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize)
        ])
        let editImage = UIImage(systemName: "pencil")
        editButton.setImage(editImage, for: .normal)
        editButton.tintColor = .systemBlue
        editButton.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        editButton.layer.cornerRadius = Constants.buttonCornerRadius
        editButton.layer.cornerCurve = .continuous
        editButton.setContentHuggingPriority(.required, for: .horizontal)
        
        let deleteImage = UIImage(systemName: "trash")
        deleteButton.setImage(deleteImage, for: .normal)
        deleteButton.tintColor = .systemRed
        deleteButton.backgroundColor = .systemRed.withAlphaComponent(0.2)
        deleteButton.layer.cornerRadius = Constants.buttonCornerRadius
        deleteButton.layer.cornerCurve = .continuous
        deleteButton.setContentHuggingPriority(.required, for: .horizontal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        interestLabel.text = nil
    }

    func configure(with interest: String) {
        interestLabel.text = interest
    }
}
