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

    var event: Observable<TableViewController.Event> {
        return eventSubject.asObservable()
    }

    // MARK: Private

    private let shoppingsProvider: ShoppingsProviding
    private let rowViewModelFactory: TableRowViewModelFactory
    private let eventSubject = PublishSubject<TableViewController.Event>()
    private let disposeBag = DisposeBag()

    private var rowViewModels = [TableRowViewModel]() {
        didSet {
            let diff = oldValue.diff(rowViewModels) { $0.isEqual(to: $1) }
            let updates = diff.elements.tableViewControllerUpdates(section: 0)
            if !updates.isEmpty {
                eventSubject.onNext(.update(updates))
            }
        }
    }

    private func setupBindings() {
        shoppingsProvider.shoppings
            .map { [weak self] in $0.flatMap { self?.rowViewModelFactory($0) } }
            .subscribe(onNext: { [weak self] in self?.rowViewModels = $0 })
            .disposed(by: disposeBag)
    }

}
