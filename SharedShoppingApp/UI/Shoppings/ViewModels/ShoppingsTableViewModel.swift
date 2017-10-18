import UIKit
import RxSwift
import RxCocoa

protocol ShoppingsTableViewModelAssembly {
    var shoppingsProvider: ShoppingsProviding { get }
    func tableRowViewModel(shopping: Shopping) -> TableRowViewModel
}

class ShoppingsTableViewModel: TableViewControllerInputs {

    init(assembly: ShoppingsTableViewModelAssembly) {
        self.assembly = assembly
        shoppingsProvider = assembly.shoppingsProvider
        setupBindings()
    }

    // MARK: TableViewControllerInputs

    func numberOfRows(in section: Int) -> Int {
        switch section {
        case 0: return rowViewModels.value.count
        default: fatalError()
        }
    }

    func rowViewModel(at indexPath: IndexPath) -> TableRowViewModel {
        switch indexPath.section {
        case 0: return rowViewModels.value[indexPath.row]
        default: fatalError()
        }
    }

    var event: Observable<TableViewController.Event> {
        return rowViewModels.asObservable().skip(1).map { _ in TableViewController.Event.reload }
    }

    // MARK: Private

    private let assembly: ShoppingsTableViewModelAssembly
    private let shoppingsProvider: ShoppingsProviding
    private let rowViewModels = Variable<[TableRowViewModel]>([])
    private let disposeBag = DisposeBag()

    private func setupBindings() {
        shoppingsProvider.shoppings
            .map { [weak self] in $0.flatMap { self?.assembly.tableRowViewModel(shopping: $0) } }
            .bind(to: rowViewModels.asWeakObserver())
            .disposed(by: disposeBag)
    }

}
