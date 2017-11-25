import Swinject
import SwinjectAutoregistration

class ShoppingsTableRowViewModelAssembly: Assembly {

    func assemble(container: Container) {
        container.register(ShoppingsTableRowViewModel.self) {
            (resolver, shopping: Shopping, navigationController: UINavigationController) in
            ShoppingsTableRowViewModel(
                dateFormatter: {
                    let formatter = DateFormatter()
                    formatter.dateStyle = .medium
                    formatter.timeStyle = .short
                    return formatter
                }(),
                shoppingRemover: resolver ~> ShoppingService.self,
                shoppingPresenter: resolver ~> (ShoppingPresenter.self, navigationController),
                alertPresenter: resolver ~> (AlertPresenter.self, navigationController as UIViewController),
                shopping: shopping
            )
        }.inObjectScope(.transient)
    }

}
