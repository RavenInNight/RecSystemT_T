import UIKit

enum PlaceSceneAssembler {
    static func assemble(restaurant: Restaurant) -> UIViewController {
        let router = PlaceRouter()
        let presenter = PlacePresenter(router: router, restaurant: restaurant)
        let view = PlaceViewController(presenter: presenter)
        
        presenter.view = view
        router.viewController = view
        return view
    }
}
