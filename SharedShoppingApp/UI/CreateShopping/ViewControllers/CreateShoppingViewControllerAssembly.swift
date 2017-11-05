import Swinject
import SwinjectAutoregistration

class CreateShoppingViewControllerAssembly: Assembly {

    func assemble(container: Container) {
        container.register(CreateShoppingViewController.self) {
            (resolver, navigationController: UINavigationController) in
            let viewModel = resolver ~> (CreateShoppingViewModel.self, navigationController)
            return CreateShoppingViewController(
                scrollViewController: resolver ~> ScrollViewController.self,
                outputs: viewModel
            )
        }
    }

}
