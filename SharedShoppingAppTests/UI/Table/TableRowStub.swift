import UIKit
@testable import SharedShoppingApp

class TableRowStub: TableRow {

    var estimatedHeightStub = CGFloat(66)
    var heightStub = CGFloat(55)
    var cellStub = UITableViewCell(style: .default, reuseIdentifier: "")

    var registerInTableViewCalled: (UITableView)?
    var estimatedHeightAtIndexPathCalled: (IndexPath)?
    var heightAtIndexPathCalled: (IndexPath)?
    var cellAtIndexPathInTableViewCalled: (IndexPath, UITableView)?

    // MARK: TableRowViewModel

    func register(in tableView: UITableView) {
        registerInTableViewCalled = (tableView)
    }

    func estimatedHeight(at indexPath: IndexPath) -> CGFloat {
        estimatedHeightAtIndexPathCalled = (indexPath)
        return estimatedHeightStub
    }

    func height(at indexPath: IndexPath) -> CGFloat {
        heightAtIndexPathCalled = (indexPath)
        return heightStub
    }

    func cell(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        cellAtIndexPathInTableViewCalled = (indexPath, tableView)
        return cellStub
    }

}
