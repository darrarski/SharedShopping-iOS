import UIKit

class ShoppingsTableViewModel: TableViewControllerInputs {

    init() {
        let names = ["A", "B", "C", "D"]
        let shoppings = names.map { Shopping(name: $0) }
        shoppingRowViewModels = shoppings.map { _ in ShoppingsTableRowViewModel() }
    }

    // MARK: TableViewControllerInputs

    func numberOfRows(in section: Int) -> Int {
        switch section {
        case 0: return shoppingRowViewModels.count
        default: fatalError()
        }
    }

    func rowViewModel(at indexPath: IndexPath) -> TableRowViewModel {
        switch indexPath.section {
        case 0: return shoppingRowViewModels[indexPath.row]
        default: fatalError()
        }
    }

    // MARK: Private

    private let shoppingRowViewModels: [ShoppingsTableRowViewModel]

}
