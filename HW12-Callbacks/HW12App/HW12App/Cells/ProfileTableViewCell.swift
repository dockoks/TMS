import UIKit

class ProfileTableViewCell: UITableViewCell {
    static let reuseIdentifier: String = "ProfileTableViewCellIdentifier"
    
    private enum Constants {
        static let padding: CGFloat = 12
        static let inset: CGFloat = 4
        static let buttonCornerRadius: CGFloat = 12
    }
    
    let titleLabel = UILabel()
    let valueLabel = UILabel()
    let editButton = UIButton(type: .system)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        editButton.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.numberOfLines = 1
        valueLabel.numberOfLines = 0
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
        contentView.addSubview(editButton)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.padding),
            titleLabel.trailingAnchor.constraint(equalTo: editButton.leadingAnchor, constant: -Constants.inset),

            valueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.inset),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.padding),

            editButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
            editButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.padding),
            editButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.padding),
            editButton.widthAnchor.constraint(equalToConstant: 48)
        ])
        
        let editImage = UIImage(systemName: "slider.horizontal.3")?.withRenderingMode(.alwaysTemplate)
        editButton.setImage(editImage, for: .normal)
        editButton.setContentHuggingPriority(.required, for: .horizontal)
        editButton.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        valueLabel.text = nil
    }

    func configure(with title: String, value: String?) {
        titleLabel.text = title
        titleLabel.textColor = .tertiaryLabel
        titleLabel.font = .systemFont(ofSize: 12, weight: .medium)
        if let value = value {
            valueLabel.text = "\(value)"
            valueLabel.textColor = .label
        } else {
            valueLabel.text = "Enter \(title.lowercased())"
            valueLabel.textColor = .secondaryLabel
        }
    }
}
