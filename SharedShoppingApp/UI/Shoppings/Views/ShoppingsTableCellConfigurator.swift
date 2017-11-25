import UIKit

class ShoppingsTableCellConfigurator: TableCellConfiguring {

    // MARK: TableCellConfiguring

    static var cellType: UITableViewCell.Type {
        return ShoppingsTableCell.self
    }

    static var rowViewModelType: TableRowViewModel.Type {
        return ShoppingsTableRowViewModel.self
    }

    func configure(_ cell: UITableViewCell, with rowViewModel: TableRowViewModel) {
        let cell = cell as! ShoppingsTableCell // swiftlint:disable:this force_cast
        let rowViewModel = rowViewModel as! ShoppingsTableRowViewModel // swiftlint:disable:this force_cast
        cell.titleLabel.text = rowViewModel.title
        cell.subtitleLabel.text = rowViewModel.subtitle
    }

}
