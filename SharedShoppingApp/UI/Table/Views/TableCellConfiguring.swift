import UIKit

protocol TableCellConfiguring {
    static var cellType: UITableViewCell.Type { get }
    static var rowViewModelType: TableRowViewModel.Type { get }
    func canConfigure(_ cell: UITableViewCell, with rowViewModel: TableRowViewModel) -> Bool
    func configure(_ cell: UITableViewCell, with rowViewModel: TableRowViewModel)
}

extension TableCellConfiguring {

    func canConfigure(_ cell: UITableViewCell, with rowViewModel: TableRowViewModel) -> Bool {
        return type(of: cell) == type(of: self).cellType &&
               type(of: rowViewModel) == type(of: self).rowViewModelType
    }

}
