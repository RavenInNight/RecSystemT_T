import UIKit

final class CafeeCell: UITableViewCell {
    static let reuseIdentifier = "CafeeCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let metroLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private let cafeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(metroLabel)
        
        contentView.addSubview(cafeImageView)
        contentView.addSubview(stackView)
        
        cafeImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cafeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cafeImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cafeImageView.widthAnchor.constraint(equalToConstant: 80),
            cafeImageView.heightAnchor.constraint(equalToConstant: 80),
            
            stackView.leadingAnchor.constraint(equalTo: cafeImageView.trailingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
        
        accessoryType = .disclosureIndicator
        selectionStyle = .none
    }
    
    func configure(with restaurant: Restaurant) {
        nameLabel.text = restaurant.name
        metroLabel.text = restaurant.metro
        cafeImageView.image = UIImage(named: restaurant.imageUrl)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cafeImageView.image = nil
        nameLabel.text = nil
        metroLabel.text = nil
    }
}
