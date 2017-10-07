import UIKit

class ShoppingsTableRow: TableRow {

    // MARK: TableRow

    func register(in tableView: UITableView) {
        tableView.register(ShoppingsTableViewCell.self, forCellReuseIdentifier: "shopping")
    }

    func estimatedHeight(at indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func height(at indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func cell(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "shopping",
                                                       for: indexPath) as? ShoppingsTableViewCell else { fatalError() }
        cell.nameLabel.text = "Shopping #\(indexPath.row + 1)"
        return cell
    }

}
