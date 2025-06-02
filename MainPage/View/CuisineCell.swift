import UIKit

class CuisineCell: UITableViewCell {
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
        }()
        
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 16)
            return label
        }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupCell()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupCell() {
            contentView.addSubview(containerView)
            containerView.addSubview(titleLabel)
            
            containerView.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
                
                titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
            ])
        }
        
        func configure(with title: String, color: UIColor?) {
            titleLabel.text = title
            
            if let color = color {
                containerView.backgroundColor = color.withAlphaComponent(0.2)
                containerView.layer.borderColor = color.cgColor
                titleLabel.textColor = color
            } else {
                containerView.backgroundColor = .white
                containerView.layer.borderColor = UIColor.lightGray.cgColor
                titleLabel.textColor = .black
            }
        }
}
