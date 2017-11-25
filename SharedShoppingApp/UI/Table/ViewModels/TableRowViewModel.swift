import UIKit

protocol TableRowViewModel {
    static var cellIdentifier: String { get }
    var estimatedHeight: CGFloat { get }
    var height: CGFloat { get }
    func cell(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell
    var actions: [UITableViewRowAction]? { get }
    func isEqual(to other: TableRowViewModel) -> Bool
    func didSelect()
}
