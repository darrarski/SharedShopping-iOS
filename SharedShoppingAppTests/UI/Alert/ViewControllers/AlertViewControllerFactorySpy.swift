import UIKit
@testable import SharedShoppingApp

class AlertViewControllerFactorySpy: AlertViewControllerCreating {

    var createdViewController: UIViewController?

    // MARK: AlertViewControllerCreating

    func createAlertViewController(viewModel: AlertViewModel) -> UIViewController {
        let viewController = UIViewController()
        createdViewController = viewController
        return viewController
    }

}
