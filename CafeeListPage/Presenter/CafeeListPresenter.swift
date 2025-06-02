import Foundation

final class CafeeListPresenter {
    var view: CafeeListViewInput?
    private let router: CafeeListRouterInput
    private var restaurants: [Restaurant] = []
    
    init(router: CafeeListRouterInput) {
        self.router = router
    }
    
    private func loadRestaurants() {
        guard let restaurants = parseCSV() else {
            view?.showError(message: "Не удалось загрузить данные")
            return
        }
        self.restaurants = restaurants
        view?.reloadData()
    }
    
    private func parseCSV() -> [Restaurant]? {
        guard let path = Bundle.main.path(forResource: "restaurants", ofType: "csv") else {
            print("CSV файл не найден")
            return nil
        }
        
        do {
            let content = try String(contentsOfFile: path, encoding: .utf8)
            let rows = content.components(separatedBy: .newlines).filter { !$0.isEmpty }
            
            guard rows.count > 1 else {
                print("CSV файл пуст или содержит только заголовок")
                return nil
            }
            
            let header = rows[0].components(separatedBy: ";")
            guard let nameIndex = header.firstIndex(of: "name"),
                  let cuisineIndex = header.firstIndex(of: "cuisine"),
                  let addressIndex = header.firstIndex(of: "address"),
                  let metroIndex = header.firstIndex(of: "metro"),
                  let imageIndex = header.firstIndex(of: "photo") else {
                print("Неверный формат заголовков CSV")
                return nil
            }
            
            return rows.dropFirst().compactMap { row in
                let columns = row.components(separatedBy: ";")
                guard columns.count > max(nameIndex, cuisineIndex, metroIndex, imageIndex) else { return nil }
                return Restaurant(
                    name: columns[nameIndex],
                    address: columns[addressIndex],
                    metro: columns[metroIndex],
                    cuisine: columns[cuisineIndex],
                    imageUrl: columns[imageIndex]
                )
            }
        } catch {
            print("Ошибка чтения CSV: \(error)")
            return nil
        }
    }
}

extension CafeeListPresenter:CafeeListPresenterInput {
    
    var numberOfRestaurants: Int {
        return restaurants.count
    }
    
    func restaurant(at index: Int) -> Restaurant {
        return restaurants[index]
    }
    
    func viewDidLoad() {
        loadRestaurants()
    }
    
    func didSelectRestaurant(at index: Int) {
        guard index < restaurants.count else { return }
        router.showPlaceDetails(for: restaurants[index])
        }
}
