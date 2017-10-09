import UIKit

class ShoppingsTableRowViewModel: TableRowViewModel {

    init(shopping: Shopping) {
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
        cell.titleLabel.text = "Shopping \(shopping.name)"
        return cell
    }

    // MARK: Private

    private let shopping: Shopping

}
