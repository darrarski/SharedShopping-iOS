import UIKit

protocol ShoppingsTableRowInputs {

}

class ShoppingsTableRow: TableRowViewModel {

    init(inputs: ShoppingsTableRowInputs) {
        self.inputs = inputs
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
        cell.nameLabel.text = "Shopping #\(indexPath.row + 1)"
        return cell
    }

    // MARK: Private

    private let inputs: ShoppingsTableRowInputs

}
