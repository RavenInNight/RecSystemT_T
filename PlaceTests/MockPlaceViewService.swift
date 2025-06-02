import Foundation
@testable import RESTaurant

class MockPlaceViewService: PlaceViewInput {
    var showRestaurantDetailsCalled = false
    var shownRestaurant: Restaurant?
    
    func showRestaurantDetails(_ restaurant: Restaurant) {
        showRestaurantDetailsCalled = true
        shownRestaurant = restaurant
    }
}
