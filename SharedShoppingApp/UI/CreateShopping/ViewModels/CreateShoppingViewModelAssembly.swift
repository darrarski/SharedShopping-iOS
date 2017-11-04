import Swinject
import SwinjectAutoregistration

class CreateShoppingViewModelAssembly: Assembly {

    func assemble(container: Container) {
        container.register(CreateShoppingViewModel.self) { resolver in
            CreateShoppingViewModel(shoppingCreator: resolver ~> ShoppingService.self)
        }
    }

}
