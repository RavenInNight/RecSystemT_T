import UIKit

protocol CafeeListRouterInput {
    func showPlaceDetails(for restaurant: Restaurant)
}

final class CafeeListRouter: CafeeListRouterInput {
    weak var viewController: UIViewController?
    
    func showPlaceDetails(for restaurant: Restaurant) {
        let placeVC = PlaceSceneAssembler.assemble(restaurant: restaurant)
        viewController?.navigationController?.pushViewController(placeVC, animated: true)
    }
}
