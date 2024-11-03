import UIKit

final class BirthdayTableViewCell: UITableViewCell {
    static let reuseIdentifier = "MonthTableViewCell"
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.font = .monospacedSystemFont(ofSize: 16, weight: .bold)
        label.textColor = .systemBackground
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.layer.cornerCurve = .continuous
        label.backgroundColor = .systemGray
        label.clipsToBounds = true
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .label
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(dayLabel)
        addSubview(nameLabel)
        
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dayLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dayLabel.heightAnchor.constraint(equalToConstant: 36),
            dayLabel.widthAnchor.constraint(equalToConstant: 36),
            
            nameLabel.leadingAnchor.constraint(equalTo: dayLabel.trailingAnchor, constant: 8),
            nameLabel.centerYAnchor.constraint(equalTo: dayLabel.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with data: BirthdayInfo) {
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "dd"
        
        dayLabel.text = dayFormatter.string(from: data.birthday)
        nameLabel.text = "\(data.name) \(data.surname)"
    }
}
