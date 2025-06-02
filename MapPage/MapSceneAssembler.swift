import UIKit

final class MapSceneAssembler {
    static func assemble() -> UIViewController {
        let presenter = MapPresenter()
        let view = MapViewController(presenter: presenter)
        
        presenter.view = view
        return view
    }
}
