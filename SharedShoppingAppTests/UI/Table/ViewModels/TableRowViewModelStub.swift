import UIKit
@testable import SharedShoppingApp

class TableRowViewModelStub: TableRowViewModel {

    init(uid: String) {
        self.uid = uid
    }

    let uid: String

    var estimatedHeightStub = CGFloat(66)
    var heightStub = CGFloat(55)
    var actionsStub: [UITableViewRowAction]?

    var estimatedHeightCalled = false
    var heightCalled = false
    var actionsCalled = false
    var didSelectCalled = false

    // MARK: TableRowViewModel

    static var cellIdentifier: String {
        return "test_cell_id"
    }

    var estimatedHeight: CGFloat {
        estimatedHeightCalled = true
        return estimatedHeightStub
    }

    var height: CGFloat {
        heightCalled = true
        return heightStub
    }

    var actions: [UITableViewRowAction]? {
        actionsCalled = true
        return actionsStub
    }

    func isEqual(to other: TableRowViewModel) -> Bool {
        guard let other = other as? TableRowViewModelStub else { return false }
        return uid == other.uid
    }

    func didSelect() {
        didSelectCalled = true
    }

}
