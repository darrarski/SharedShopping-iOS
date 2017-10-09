import UIKit

protocol ShoppingsTableRowViewModelAssembly {
    var dateFormatter: DateFormatter { get }
    func action(style: UITableViewRowActionStyle,
                title: String?,
                handler: @escaping (UITableViewRowAction, IndexPath) -> Void) -> UITableViewRowAction
}

class ShoppingsTableRowViewModel: TableRowViewModel {

    init(shopping: Shopping, assembly: ShoppingsTableRowViewModelAssembly) {
        self.shopping = shopping
        self.assembly = assembly
        self.dateFormatter = assembly.dateFormatter
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
        let delete = assembly.action(style: .destructive, title: "Delete") { (_, _) in
            // TODO:
        }
        return [delete]
    }

    // MARK: Private

    private let assembly: ShoppingsTableRowViewModelAssembly
    private let shopping: Shopping
    private let dateFormatter: DateFormatter

}
