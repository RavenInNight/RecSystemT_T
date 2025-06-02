import UIKit

enum CafeeListAssembler {
    static func assemble() -> UIViewController {
        let router = CafeeListRouter()
        let presenter = CafeeListPresenter(router: router)
        let view = CafeeListViewController(presenter: presenter)
        
        presenter.view = view
        router.viewController = view
        return view
    }
}
