import UIKit

protocol TableRow {
    func register(in tableView: UITableView)
    func estimatedHeight(at indexPath: IndexPath) -> CGFloat
    func height(at indexPath: IndexPath) -> CGFloat
    func cell(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell
}
