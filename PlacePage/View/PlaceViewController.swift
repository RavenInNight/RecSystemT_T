import UIKit

final class PlaceViewController: UIViewController {
    private let presenter: PlacePresenterInput
    private var restaurant: Restaurant?
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let nameLabel = UILabel()
    private let addressLabel = UILabel()
    private let cuisineLabel = UILabel()
    
    init(presenter: PlacePresenterInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Детали ресторана"
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        let labels = [nameLabel, addressLabel, cuisineLabel]
        labels.forEach {
            $0.numberOfLines = 0
            $0.textAlignment = .left
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        addressLabel.textColor = .darkGray
        cuisineLabel.textColor = .systemBlue
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            addressLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            cuisineLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 12),
            cuisineLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            cuisineLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
        ])
    }
}

extension PlaceViewController:  PlaceViewInput{
    func showRestaurantDetails(_ restaurant: Restaurant) {
        self.restaurant = restaurant
        nameLabel.text = restaurant.name
        addressLabel.text = "📍 Адрес: \(restaurant.address)"
        cuisineLabel.text = "🍽 Кухня: \(restaurant.cuisine)"
    }
}
