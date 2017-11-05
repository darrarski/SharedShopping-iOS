import UIKit

class CreatedShoppingPresenter: CreatedShoppingPresenting {

    typealias ShoppingViewControllerFactory = (Shopping) -> UIViewController

    init(navigationController: UINavigationController,
         shoppingViewControllerFactory: @escaping ShoppingViewControllerFactory) {
        self.navigationController = navigationController
        self.shoppingViewControllerFactory = shoppingViewControllerFactory
    }

    // MARK: CreatedShoppingPresenting

    func presentCreatedShopping(_ shopping: Shopping) {
        let viewController = self.shoppingViewControllerFactory(shopping)
        var viewControllers = navigationController.viewControllers
        let index = viewControllers.index(where: { $0.isKind(of: CreateShoppingViewController.self) })
        if let index = index {
            viewControllers.removeSubrange((index..<viewControllers.endIndex))
        }
        viewControllers.append(viewController)
        navigationController.setViewControllers(viewControllers, animated: true)
    }

    // MARK: Private

    private let navigationController: UINavigationController
    private let shoppingViewControllerFactory: ShoppingViewControllerFactory

}
