import UIKit

protocol MainRouterInput: AnyObject {
    func showResults(for cuisines: [String])
    func goBack()
}

final class MainRouter: MainRouterInput {
    weak var viewController: UIViewController?
    
    func showResults(for cuisines: [String]) {
        let resultVC = ResultSceneAssembler.assemble(selectedCuisines: cuisines)
        viewController?.navigationController?.pushViewController(resultVC, animated: true)
    }
    
    func goBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
