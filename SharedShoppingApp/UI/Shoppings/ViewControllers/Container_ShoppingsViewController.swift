import UIKit

extension Container {

    var shoppingsViewController: ShoppingsViewController {
        let viewModel = shoppingsViewModel
        return ShoppingsViewController(
            tableViewControllerFactory: { self.shoppingsTableViewController },
            inputs: viewModel,
            outputs: viewModel
        )
    }

    private var shoppingsTableViewController: UIViewController {
        return TableViewController(style: .plain, inputs: shoppingsTableViewModel)
    }

}
