import Swinject
import SwinjectAutoregistration

class ShoppingsViewModelAssembly: Assembly {

    func assemble(container: Container) {
        container.register(ShoppingsViewModel.self) {
            (resolver, navigationController: UINavigationController) in
            ShoppingsViewModel(
                createShoppingPresenter: resolver ~> (CreateShoppingPresenter.self, navigationController)
            )
        }
    }

}
