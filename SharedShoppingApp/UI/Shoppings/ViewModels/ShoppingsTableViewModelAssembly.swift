import Swinject
import SwinjectAutoregistration

class ShoppingsTableViewModelAssembly: Assembly {

    func assemble(container: Container) {
        container.register(ShoppingsTableViewModel.self) { resolver in
            ShoppingsTableViewModel(
                shoppingsProvider: resolver ~> ShoppingService.self,
                rowViewModelFactory: { resolver ~> (ShoppingsTableRowViewModel.self, $0) }
            )
        }
    }

}
