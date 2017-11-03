import UIKit

protocol AlertViewControllerCreating {
    func createAlertViewController(viewModel: AlertViewModel) -> UIViewController
}

class AlertViewControllerFactory: AlertViewControllerCreating {

    typealias ActionFactory = (String, UIAlertActionStyle, @escaping (UIAlertAction) -> Void) -> UIAlertAction

    init(actionFactory: @escaping ActionFactory) {
        self.actionFactory = actionFactory
    }

    // MARK: AlertViewControllerCreating

    func createAlertViewController(viewModel: AlertViewModel) -> UIViewController {
        let viewController = UIAlertController(title: viewModel.title,
                                               message: viewModel.message,
                                               preferredStyle: .alert)
        viewModel.actions.forEach { actionViewModel in
            let action = actionFactory(actionViewModel.title, alertActionStyle(for: actionViewModel.style), { _ in
                actionViewModel.handler()
            })
            viewController.addAction(action)
        }
        return viewController
    }

    // MARK: Private

    private let actionFactory: ActionFactory

    private func alertActionStyle(for style: AlertActionViewModel.Style) -> UIAlertActionStyle {
        switch style {
        case .confirm: return .default
        case .cancel: return .cancel
        case .destruct: return .destructive
        }
    }

}
