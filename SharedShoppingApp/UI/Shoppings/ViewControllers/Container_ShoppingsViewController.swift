import UIKit

extension Container {

    var shoppingsViewController: ShoppingsViewController {
        let viewModel = shoppingsViewModel
        return ShoppingsViewController(assembly: Assembly(container: self), inputs: viewModel)
    }

    private struct Assembly: ShoppingsViewControllerAssembly {

        let container: Container

        var tableViewController: UIViewController {
            let viewModel = container.shoppingsTableViewModel
            return TableViewController(style: .plain, inputs: viewModel)
        }

    }

}
