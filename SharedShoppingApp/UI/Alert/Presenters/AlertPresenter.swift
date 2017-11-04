import UIKit

class AlertPresenter: AlertPresenting {

    init(parentViewController: UIViewController,
         alertViewControllerFactory: AlertViewControllerCreating) {
        self.parentViewController = parentViewController
        self.alertViewControllerFactory = alertViewControllerFactory
    }

    // MARK: AlertPresenting

    func presentAlert(_ viewModel: AlertViewModel) {
        let viewController = alertViewControllerFactory.createAlertViewController(viewModel: viewModel)
        parentViewController.present(viewController, animated: true)
    }

    // MARK: Private

    private let parentViewController: UIViewController
    private let alertViewControllerFactory: AlertViewControllerCreating

}
