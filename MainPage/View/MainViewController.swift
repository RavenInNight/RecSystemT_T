import UIKit

final class MainViewController: UIViewController {
    private let presenter: MainPresenterInput
    
    private let cuisines = ["Различные", "Армянская", "Средиземноморская", "Русская", "Французская", "Итальянская", "Грузинская", "Кафе", "Европейская", "Азиатская"]
    
    private let colors: [UIColor] = [
            .systemPurple,
            .systemPink,
            .systemYellow
        ]
    
    private var selectedCuisines: [(name: String, color: UIColor)] = []
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Ваши предпочтения"
        title.font = UIFont.boldSystemFont(ofSize: 24)
        title.textAlignment = .center
        return title
    }()
    
    private let discripLabel: UILabel = {
        let discrip = UILabel()
        discrip.text = "Выберите то, что Вам нравится и мы подберем рестораны в соответствии с Вашими пожеланиями"
        discrip.font = UIFont.systemFont(ofSize: 16)
        discrip.textAlignment = .center
        discrip.numberOfLines = 0
        discrip.textColor = .gray
        return discrip
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Далее", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    init(presenter: MainPresenterInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        tableView.register(CuisineCell.self, forCellReuseIdentifier: "CuisineCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        [
            titleLabel,
            discripLabel,
            tableView,
            nextButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            discripLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            discripLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            discripLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: discripLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -20),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func nextButtonTapped() {
        let selected = selectedCuisines.map { $0.name }
        presenter.didSelectCuisines(selected)
    }
}

extension MainViewController: MainViewInput {
    
    func getNextColor() -> UIColor {
        let index = selectedCuisines.count % colors.count
        return colors[index]
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cuisines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CuisineCell", for: indexPath) as? CuisineCell else {
            return UITableViewCell()
        }
        let cuisine = cuisines[indexPath.row]
        
        if let selected = selectedCuisines.first(where: { $0.name == cuisine }) {
                    cell.configure(with: cuisine, color: selected.color)
                } else {
                    cell.configure(with: cuisine, color: nil)
                }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cuisine = cuisines[indexPath.row]
        
        if let index = selectedCuisines.firstIndex(where: { $0.name == cuisine }) {
                    selectedCuisines.remove(at: index)
                } else {
                    let color = getNextColor()
                    selectedCuisines.append((name: cuisine, color: color))
                }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
