import UIKit

protocol ShoppingsTableViewModelAssembly {
    func shoppingsTableRowViewModel(shopping: Shopping) -> ShoppingsTableRowViewModel
}

class ShoppingsTableViewModel: TableViewControllerInputs {

    init(assembly: ShoppingsTableViewModelAssembly) {
        rowViewModels = ["A", "B", "C", "D"]
            .map { Shopping(name: $0, date: Date()) }
            .map { assembly.shoppingsTableRowViewModel(shopping: $0) }
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

    private let rowViewModels: [ShoppingsTableRowViewModel]

}
