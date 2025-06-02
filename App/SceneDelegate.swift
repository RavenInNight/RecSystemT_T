import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = MainSceneAssembler().makeScene()
        window.makeKeyAndVisible()
        
        self.window = window
        
        window.rootViewController = setupTabBarController()
    }
    
    func setupTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        
        let mainNav = MainSceneAssembler().makeScene() as! UINavigationController
        
        let resultTabVC = CafeeListViewController(presenter: CafeeListPresenter(router: CafeeListRouter()))
        let mapTabVC = MapViewController(presenter: MapPresenter())
        
        resultTabVC.tabBarItem = UITabBarItem(title: "Результаты", image: UIImage(systemName: "list.bullet"), tag: 1)
        mapTabVC.tabBarItem = UITabBarItem(title: "Карта", image: UIImage(systemName: "map"), tag: 2)
        
        let resultNav = UINavigationController(rootViewController: resultTabVC)
        let mapNav = UINavigationController(rootViewController: mapTabVC)
        
        mainNav.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(systemName: "house"), tag: 0)
        
        tabBarController.viewControllers = [mainNav, resultNav, mapNav]
        
        return tabBarController
    }

}

