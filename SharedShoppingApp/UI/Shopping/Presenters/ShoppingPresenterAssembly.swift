import Swinject
import SwinjectAutoregistration

class ShoppingPresenterAssembly: Assembly {

    func assemble(container: Container) {
        container.register(ShoppingPresenter.self) { resolver, navigationController in
            ShoppingPresenter(
                navigationController: navigationController,
                viewControllerFactory: { _ in resolver ~> ShoppingViewController.self }
            )
        }
    }

}
