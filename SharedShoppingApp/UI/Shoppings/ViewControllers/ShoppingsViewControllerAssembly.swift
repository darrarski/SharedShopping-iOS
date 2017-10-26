import Swinject
import SwinjectAutoregistration

class ShoppingsViewControllerAssembly: Assembly {

    func assemble(container: Container) {
        container.register(ShoppingsViewController.self) { resolver in
            let viewModel = resolver ~> ShoppingsViewModel.self
            return ShoppingsViewController(
                tableViewControllerFactory: {
                    TableViewController(style: .plain, inputs: resolver ~> ShoppingsTableViewModel.self)
                },
                inputs: viewModel,
                outputs: viewModel
            )
        }
    }

}
