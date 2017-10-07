import UIKit

extension Container {

    var shoppingsViewController: ShoppingsViewController {
        return ShoppingsViewController(assembly: Assembly(container: self))
    }

    private struct Assembly: ShoppingsViewControllerAssembly {

        let container: Container

        var tableViewController: UIViewController {
            let viewModel = container.shoppingsTableViewModel
            return TableViewController(style: .plain, inputs: viewModel)
        }

    }

}
