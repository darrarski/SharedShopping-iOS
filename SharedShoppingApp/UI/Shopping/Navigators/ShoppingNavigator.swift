import UIKit

class ShoppingNavigator: ShoppingNavigating {

    init(navigationController: UINavigationController,
         viewControllerFactory: @escaping (Shopping) -> UIViewController) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }

    // MARK: ShoppingNavigating

    func navigateToShopping(_ shopping: Shopping) {
        let viewController = self.viewControllerFactory(shopping)
        navigationController.pushViewController(viewController, animated: true)
    }

    // MARK: Private

    private let navigationController: UINavigationController
    private let viewControllerFactory: (Shopping) -> UIViewController

}
