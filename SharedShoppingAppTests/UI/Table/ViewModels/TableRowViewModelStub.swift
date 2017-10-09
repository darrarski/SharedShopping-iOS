import UIKit
@testable import SharedShoppingApp

class TableRowViewModelStub: TableRowViewModel {

    var estimatedHeightStub = CGFloat(66)
    var heightStub = CGFloat(55)
    var cellStub = UITableViewCell(style: .default, reuseIdentifier: "")

    var registerInTableViewCalled: (UITableView)?
    var estimatedHeightCalled = false
    var heightCalled = false
    var cellAtIndexPathInTableViewCalled: (IndexPath, UITableView)?

    // MARK: TableRowViewModel

    func register(in tableView: UITableView) {
        registerInTableViewCalled = (tableView)
    }

    var estimatedHeight: CGFloat {
        estimatedHeightCalled = true
        return estimatedHeightStub
    }

    var height: CGFloat {
        heightCalled = true
        return heightStub
    }

    func cell(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        cellAtIndexPathInTableViewCalled = (indexPath, tableView)
        return cellStub
    }

}
