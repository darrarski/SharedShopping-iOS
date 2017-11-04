import Swinject
import SwinjectAutoregistration

class CreateShoppingViewModelAssembly: Assembly {

    func assemble(container: Container) {
        container.register(CreateShoppingViewModel.self) {
            (resolver, navigationController: UINavigationController) in
            CreateShoppingViewModel(
                shoppingCreator: resolver ~> ShoppingService.self,
                createdShoppingPresenter: resolver ~> (CreatedShoppingPresenter.self, navigationController)
            )
        }
    }

}
