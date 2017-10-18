import UIKit

extension Container {

    func shoppingsTableRowViewModel(shopping: Shopping) -> ShoppingsTableRowViewModel {
        return ShoppingsTableRowViewModel(shopping: shopping, assembly: Assembly(container: self))
    }

    private struct Assembly: ShoppingsTableRowViewModelAssembly {

        let container: Container

        // MARK: ShoppingsTableRowViewModelAssembly

        var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter
        }

        func action(style: UITableViewRowActionStyle,
                    title: String?,
                    handler: @escaping (UITableViewRowAction, IndexPath) -> Void) -> UITableViewRowAction {
            return UITableViewRowAction(style: style, title: title, handler: handler)
        }

        var shoppingRemover: ShoppingRemoving {
            return container.shoppingService
        }

    }

}
