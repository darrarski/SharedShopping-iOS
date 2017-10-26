import UIKit

class ShoppingsTableRowViewModel: TableRowViewModel {

    typealias TableViewRowActionFactory = (UITableViewRowActionStyle,
                                           String?,
                                           @escaping (UITableViewRowAction, IndexPath) -> Void) -> UITableViewRowAction

    init(dateFormatter: DateFormatter,
         rowActionFactory: @escaping TableViewRowActionFactory,
         shoppingRemover: ShoppingRemoving,
         shopping: Shopping) {
        self.dateFormatter = dateFormatter
        self.rowActionFactory = rowActionFactory
        self.shoppingRemover = shoppingRemover
        self.shopping = shopping
    }

    // MARK: TableRowViewModel

    func register(in tableView: UITableView) {
        tableView.register(ShoppingsTableViewCell.self, forCellReuseIdentifier: "shopping")
    }

    var estimatedHeight: CGFloat {
        return 60
    }

    var height: CGFloat {
        return UITableViewAutomaticDimension
    }

    func cell(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "shopping",
                                                       for: indexPath) as? ShoppingsTableViewCell else { fatalError() }
        cell.titleLabel.text = shopping.name
        cell.subtitleLabel.text = dateFormatter.string(from: shopping.date)
        return cell
    }

    var actions: [UITableViewRowAction]? {
        let delete = rowActionFactory(.destructive, "Delete") { [weak self] (_, _) in
            self?.handleDeleteAction()
        }
        return [delete]
    }

    func isEqual(to other: TableRowViewModel) -> Bool {
        guard let other = other as? ShoppingsTableRowViewModel else { return false }
        return shopping.isEqual(to: other.shopping)
    }

    // MARK: Private

    private let dateFormatter: DateFormatter
    private let rowActionFactory: TableViewRowActionFactory
    private let shoppingRemover: ShoppingRemoving
    private let shopping: Shopping

    private func handleDeleteAction() {
        shoppingRemover.removeShopping(shopping)
    }

}
