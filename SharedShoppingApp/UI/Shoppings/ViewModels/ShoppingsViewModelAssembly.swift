import Swinject
import SwinjectAutoregistration

class ShoppingsViewModelAssembly: Assembly {

    func assemble(container: Container) {
        container.register(ShoppingsViewModel.self) { resolver in
            ShoppingsViewModel(shoppingCreator: resolver ~> ShoppingService.self)
        }
    }

}
