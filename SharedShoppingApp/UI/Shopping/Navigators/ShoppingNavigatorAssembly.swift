import Swinject
import SwinjectAutoregistration

class ShoppingNavigatorAssembly: Assembly {

    func assemble(container: Container) {
        container.register(ShoppingNavigator.self) { resolver, navigationController in
            ShoppingNavigator(
                navigationController: navigationController,
                viewControllerFactory: { _ in resolver ~> ShoppingViewController.self }
            )
        }
    }

}
