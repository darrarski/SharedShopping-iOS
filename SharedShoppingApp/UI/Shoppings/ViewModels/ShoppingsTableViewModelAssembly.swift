import Swinject
import SwinjectAutoregistration

class ShoppingsTableViewModelAssembly: Assembly {

    func assemble(container: Container) {
        container.register(ShoppingsTableViewModel.self) {
            (resolver, navigationController: UINavigationController) in
            ShoppingsTableViewModel(
                shoppingsProvider: resolver ~> ShoppingService.self,
                rowViewModelFactory: { resolver ~> (ShoppingsTableRowViewModel.self, ($0, navigationController)) }
            )
        }
    }

}
