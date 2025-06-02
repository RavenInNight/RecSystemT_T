import UIKit

protocol ResultRouterInput: AnyObject {
    func goBack()
    func showPlaceDetails(for restaurant: Restaurant)
}

final class ResultRouter: ResultRouterInput {
    weak var viewController: UIViewController?
    
    func goBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func showPlaceDetails(for restaurant: Restaurant) {
        let placeVC = PlaceSceneAssembler.assemble(restaurant: restaurant)
        viewController?.navigationController?.pushViewController(placeVC, animated: true)
    }
}
