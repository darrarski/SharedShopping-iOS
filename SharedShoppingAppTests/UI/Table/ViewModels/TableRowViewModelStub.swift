import UIKit
@testable import SharedShoppingApp

class TableRowViewModelStub: TableRowViewModel {

    init(shopping: Shopping) {
        self.shopping = shopping
    }

    let shopping: Shopping

    var estimatedHeightStub = CGFloat(66)
    var heightStub = CGFloat(55)
    var cellStub = UITableViewCell(style: .default, reuseIdentifier: "")
    var actionsStub: [UITableViewRowAction]?

    var registerInTableViewCalled: (UITableView)?
    var estimatedHeightCalled = false
    var heightCalled = false
    var cellAtIndexPathInTableViewCalled: (IndexPath, UITableView)?
    var actionsCalled = false
    var didSelectCalled = false

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

    var actions: [UITableViewRowAction]? {
        actionsCalled = true
        return actionsStub
    }

    func isEqual(to other: TableRowViewModel) -> Bool {
        guard let other = other as? TableRowViewModelStub else { return false }
        return shopping.isEqual(to: other.shopping)
    }

    func didSelect() {
        didSelectCalled = true
    }

}
