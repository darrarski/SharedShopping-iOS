import UIKit

class ShoppingPresenter: ShoppingPresenting {

    init(navigationController: UINavigationController,
         viewControllerFactory: @escaping (Shopping) -> UIViewController) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }

    // MARK: ShoppingPresenting

    func presentShopping(_ shopping: Shopping) {
        let viewController = self.viewControllerFactory(shopping)
        navigationController.pushViewController(viewController, animated: true)
    }

    // MARK: Private

    private let navigationController: UINavigationController
    private let viewControllerFactory: (Shopping) -> UIViewController

}
