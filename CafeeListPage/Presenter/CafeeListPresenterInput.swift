protocol CafeeListPresenterInput {
    func viewDidLoad()
    var numberOfRestaurants: Int { get }
    func restaurant(at index: Int) -> Restaurant
    func didSelectRestaurant(at index: Int)
}
