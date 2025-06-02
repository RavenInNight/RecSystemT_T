import UIKit

final class MainSceneAssembler {
    func makeScene() -> UIViewController {
        let router = MainRouter()
        let presenter = MainPresenter(router: router)
        let view = MainViewController(presenter: presenter)
        
        presenter.view = view
        router.viewController = view
        
        let navigationController = UINavigationController(rootViewController: view)
        return navigationController
    }
}
