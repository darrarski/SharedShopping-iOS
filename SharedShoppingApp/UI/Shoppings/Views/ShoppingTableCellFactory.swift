import UIKit

class ShoppingsTableCellFactory: TableCellCreating {

    // MARK: TableCellCreating

    func register(in tableView: UITableView) {
        tableView.register(ShoppingsTableCell.self, forCellReuseIdentifier: ShoppingsTableRowViewModel.cellIdentifier)
    }

    func cell(withId identifier: String, at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }

}
