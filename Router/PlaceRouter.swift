import UIKit

protocol PlaceRouterInput {
    func goBack()
}

final class PlaceRouter: PlaceRouterInput {
    weak var viewController: UIViewController?
    
    func goBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
