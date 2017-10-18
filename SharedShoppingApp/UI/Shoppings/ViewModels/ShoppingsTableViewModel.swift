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

    private let assembly: ShoppingsTableViewModelAssembly
    private let shoppingsProvider: ShoppingsProviding
    private let eventSubject = PublishSubject<TableViewController.Event>()
    private let disposeBag = DisposeBag()

    private var rowViewModels = [TableRowViewModel]() {
        didSet {
            eventSubject.onNext(.reload)
        }
    }

    private func setupBindings() {
        shoppingsProvider.shoppings
            .map { [weak self] in $0.flatMap { self?.assembly.tableRowViewModel(shopping: $0) } }
            .subscribe(onNext: { [weak self] in self?.rowViewModels = $0 })
            .disposed(by: disposeBag)
    }

}
