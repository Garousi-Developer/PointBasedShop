import UIKit

class TabController: SecondaryController {
    func didSelect(viewController: UIViewController) {
        
    }
}
extension TabController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        didSelect(viewController: viewController)
    }
}
