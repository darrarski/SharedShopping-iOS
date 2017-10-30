import Swinject
import SwinjectAutoregistration

class ShoppingViewControllerAssembly: Assembly {

    func assemble(container: Container) {
        container.register(ShoppingViewController.self) { _ in
            return ShoppingViewController()
        }
    }

}
