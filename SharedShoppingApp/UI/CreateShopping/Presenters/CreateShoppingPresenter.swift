import UIKit

class CreateShoppingPresenter: CreateShoppingPresenting {

    typealias ViewControllerFactory = () -> UIViewController

    init(navigationController: UINavigationController,
         viewControllerFactory: @escaping ViewControllerFactory) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }

    // MARK: CreateShoppingPresenting

    func presentCreateShopping() {
        let viewController = self.viewControllerFactory()
        navigationController.pushViewController(viewController, animated: true)
    }

    // MARK: Priavte

    private let navigationController: UINavigationController
    private let viewControllerFactory: ViewControllerFactory

}
