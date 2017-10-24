import UIKit

extension Container {

    func shoppingsTableRowViewModel(shopping: Shopping) -> ShoppingsTableRowViewModel {
        return ShoppingsTableRowViewModel(
            dateFormatter: {
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                formatter.timeStyle = .short
                return formatter
            }(),
            rowActionFactory: { style, title, handler in
                UITableViewRowAction(style: style, title: title, handler: handler)
            },
            shoppingRemover: shoppingService,
            shopping: shopping
        )
    }

}
