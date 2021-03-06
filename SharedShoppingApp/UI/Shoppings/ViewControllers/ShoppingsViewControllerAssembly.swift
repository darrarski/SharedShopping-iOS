import Swinject
import SwinjectAutoregistration

class ShoppingsViewControllerAssembly: Assembly {

    func assemble(container: Container) {
        container.register(ShoppingsViewController.self) {
            (resolver, navigationController: UINavigationController) in
            let viewModel = resolver ~> (ShoppingsViewModel.self, navigationController)
            return ShoppingsViewController(
                tableViewControllerFactory: {
                    TableViewController(
                        style: .plain,
                        inputs: resolver ~> (ShoppingsTableViewModel.self, navigationController)
                    )
                },
                inputs: viewModel,
                outputs: viewModel
            )
        }
    }

}
