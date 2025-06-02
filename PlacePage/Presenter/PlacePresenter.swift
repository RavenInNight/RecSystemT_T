import Foundation

final class PlacePresenter {
    var view: PlaceViewInput?
    private let router: PlaceRouterInput
    private let restaurant: Restaurant

    init(router: PlaceRouterInput, restaurant: Restaurant) {
        self.router = router
        self.restaurant = restaurant
    }
}

extension PlacePresenter: PlacePresenterInput {
    func viewDidLoad() {
        view?.showRestaurantDetails(restaurant)
    }
}
