import Swinject
import SwinjectAutoregistration

class CreateShoppingPresenterAssembly: Assembly {

    func assemble(container: Container) {
        container.register(CreateShoppingPresenter.self) { resolver, navigationController in
            CreateShoppingPresenter(
                navigationController: navigationController,
                viewControllerFactory: { resolver ~> (CreateShoppingViewController.self, navigationController) }
            )
        }
    }

}
