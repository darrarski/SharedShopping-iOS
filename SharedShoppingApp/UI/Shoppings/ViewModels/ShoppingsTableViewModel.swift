import UIKit

protocol ShoppingsTableViewModelAssembly {
    var shoppingsProvider: ShoppingsProviding { get }
    func tableRowViewModel(shopping: Shopping) -> TableRowViewModel
}

class ShoppingsTableViewModel: TableViewControllerInputs {

    init(assembly: ShoppingsTableViewModelAssembly) {
        shoppingsProvider = assembly.shoppingsProvider
        rowViewModels = shoppingsProvider.shoppings().map { assembly.tableRowViewModel(shopping: $0) }
    }

    // MARK: TableViewControllerInputs

    func numberOfRows(in section: Int) -> Int {
        switch section {
        case 0: return rowViewModels.count
        default: fatalError()
        }
    }

    func rowViewModel(at indexPath: IndexPath) -> TableRowViewModel {
        switch indexPath.section {
        case 0: return rowViewModels[indexPath.row]
        default: fatalError()
        }
    }

    // MARK: Private

    private let shoppingsProvider: ShoppingsProviding
    private let rowViewModels: [TableRowViewModel]

}
