import UIKit

enum ResultSceneAssembler {
    static func assemble(selectedCuisines: [String]) -> UIViewController {
        let router = ResultRouter()
        let presenter = ResultPresenter(router: router, selectedCuisines: selectedCuisines)
        let view = ResultViewController(presenter: presenter)
        
        presenter.view = view
        router.viewController = view
        return view
    }
}
