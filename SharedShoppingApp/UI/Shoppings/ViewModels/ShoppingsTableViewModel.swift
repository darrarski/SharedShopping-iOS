import UIKit
import RxSwift
import RxCocoa
import Differ

class ShoppingsTableViewModel: TableViewControllerInputs {

    typealias TableRowViewModelFactory = (Shopping) -> TableRowViewModel

    init(shoppingsProvider: ShoppingsProviding,
         rowViewModelFactory: @escaping TableRowViewModelFactory) {
        self.shoppingsProvider = shoppingsProvider
        self.rowViewModelFactory = rowViewModelFactory
        setupBindings()
    }

    // MARK: TableViewControllerInputs

    var rowViewModels: Observable<[TableRowViewModel]> {
        return rowViewModelsVar.asObservable()
    }

    // MARK: Private

    private let shoppingsProvider: ShoppingsProviding
    private let rowViewModelFactory: TableRowViewModelFactory
    private let rowViewModelsVar = Variable<[TableRowViewModel]>([])
    private let disposeBag = DisposeBag()

    private func setupBindings() {
        shoppingsProvider.shoppings
            .map { [weak self] in $0.flatMap { self?.rowViewModelFactory($0) } }
            .bind(to: rowViewModelsVar.asWeakObserver())
            .disposed(by: disposeBag)
    }

}
