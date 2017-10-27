import Swinject
import SwinjectAutoregistration

class ShoppingsTableRowViewModelAssembly: Assembly {

    func assemble(container: Container) {
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
