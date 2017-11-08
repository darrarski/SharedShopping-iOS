import Swinject
import SwinjectAutoregistration
import ScrollViewController

class CreateShoppingViewControllerAssembly: Assembly {

    func assemble(container: Container) {
        container.register(CreateShoppingViewController.self) {
            (resolver, navigationController: UINavigationController) in
            let viewModel = resolver ~> (CreateShoppingViewModel.self, navigationController)
            return CreateShoppingViewController(
                scrollViewController: ScrollViewController(),
                outputs: viewModel
            )
        }
    }

}
