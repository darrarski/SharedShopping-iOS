import UIKit

protocol TableRowViewModel {
    func register(in tableView: UITableView)
    var estimatedHeight: CGFloat { get }
    var height: CGFloat { get }
    func cell(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell
}