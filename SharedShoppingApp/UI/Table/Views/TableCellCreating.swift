import UIKit

protocol TableCellCreating {
    func register(in tableView: UITableView)
    func cell(withId identifier: String, at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell
}
