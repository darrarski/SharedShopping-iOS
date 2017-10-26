import Swinject
import SwinjectAutoregistration

class ShoppingsAssembly: Assembly {

    func assemble(container: Swinject.Container) {
        container.register(ShoppingsViewController.self) { resolver in
            let viewModel = resolver ~> ShoppingsViewModel.self
            return ShoppingsViewController(
                tableViewControllerFactory: {
                    TableViewController(style: .plain, inputs: resolver ~> ShoppingsTableViewModel.self)
                },
                inputs: viewModel,
                outputs: viewModel
            )
        }
        container.register(ShoppingsViewModel.self) { resolver in
            ShoppingsViewModel(shoppingCreator: resolver ~> ShoppingService.self)
        }
        container.register(ShoppingsTableViewModel.self) { resolver in
            ShoppingsTableViewModel(
                shoppingsProvider: resolver ~> ShoppingService.self,
                rowViewModelFactory: { resolver ~> (ShoppingsTableRowViewModel.self, $0) })
        }
        container.register(ShoppingsTableRowViewModel.self) { resolver, shopping in
            ShoppingsTableRowViewModel(
                dateFormatter: {
                    let formatter = DateFormatter()
                    formatter.dateStyle = .medium
                    formatter.timeStyle = .short
                    return formatter
                }(),
                rowActionFactory: { style, title, handler in
                    UITableViewRowAction(style: style, title: title, handler: handler)
                },
                shoppingRemover: resolver ~> ShoppingService.self,
                shopping: shopping
            )
        }
    }

}
