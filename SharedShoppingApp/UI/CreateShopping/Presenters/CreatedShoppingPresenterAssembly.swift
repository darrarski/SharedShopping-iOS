import Swinject
import SwinjectAutoregistration

class CreatedShoppingPresenterAssembly: Assembly {

    func assemble(container: Container) {
        container.register(CreatedShoppingPresenter.self) { resolver, navigationController in
            CreatedShoppingPresenter(
                navigationController: navigationController,
                viewControllerFactory: { _ in resolver ~> ShoppingViewController.self }
            )
        }
    }

}
