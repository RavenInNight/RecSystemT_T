import Foundation

final class MainPresenter {
    var view: MainViewInput?
    private let router: MainRouterInput
    
    init(router: MainRouterInput) {
        self.router = router
    }
}
    
extension MainPresenter: MainPresenterInput {
    func didSelectCuisines(_ cuisines: [String]) {
            router.showResults(for: cuisines)
    }
}
