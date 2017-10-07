import UIKit

class ShoppingsTableViewModel: TableViewControllerInputs {

    // MARK: TableViewControllerInputs

    func numberOfRows(in section: Int) -> Int {
        guard section == 0 else { return 0 }
        return items.count
    }

    func row(at indexPath: IndexPath) -> TableRow {
        return ShoppingsTableRow()
    }

    // MARK: Private

    private let items = ["A", "B", "C", "D"]

}
