import UIKit

class CreatedShoppingPresenter: CreatedShoppingPresenting {

    typealias ViewControllerFactory = (Shopping) -> UIViewController

    init(navigationController: UINavigationController,
         viewControllerFactory: @escaping ViewControllerFactory) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }

    // MARK: CreatedShoppingPresenting

    func presentCreatedShopping(_ shopping: Shopping) {
        let viewController = self.viewControllerFactory(shopping)
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
    private let viewControllerFactory: ViewControllerFactory

}
