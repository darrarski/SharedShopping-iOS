import UIKit
import RxSwift

protocol TableViewControllerInputs {
    var rowViewModels: Observable<[TableRowViewModel]> { get }
}

class TableViewController: UITableViewController {

    enum Update {
        case insert(row: Int, inSection: Int)
        case delete(row: Int, inSection: Int)
    }

    init(style: UITableViewStyle,
         cellFactory: TableCellCreating,
         cellConfigurators: [TableCellConfiguring],
         rowActionFactory: TableViewRowActionCreating,
         inputs: TableViewControllerInputs) {
        self.cellFactory = cellFactory
        self.cellConfigurators = cellConfigurators
        self.rowActionFactory = rowActionFactory
        self.inputs = inputs
        super.init(style: style)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: View

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
        cellFactory.register(in: tableView)
        setupBindings()
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowViewModels[indexPath.row].height
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowViewModels[indexPath.row].estimatedHeight
    }

    override func tableView(_ tableView: UITableView,
                            editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return rowViewModels[indexPath.row].actions?.map { rowActionFactory.tableViewRowAction(for: $0) }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowViewModels[indexPath.row].didSelect()
    }

    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return rowViewModels.count
        default: return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowViewModel = rowViewModels[indexPath.row]
        let cell = cellFactory.cell(withId: type(of: rowViewModel).cellIdentifier, at: indexPath, in: tableView)
        let configurator = cellConfigurators.first(where: { $0.canConfigure(cell, with: rowViewModel) })
        configurator?.configure(cell, with: rowViewModel)
        return cell
    }

    // MARK: Private

    private let cellFactory: TableCellCreating
    private let cellConfigurators: [TableCellConfiguring]
    private let rowActionFactory: TableViewRowActionCreating
    private let inputs: TableViewControllerInputs
    private let disposeBag = DisposeBag()

    private var rowViewModels = [TableRowViewModel]() {
        didSet {
            let diff = oldValue.diff(rowViewModels) { $0.isEqual(to: $1) }
            let updates = diff.elements.tableViewControllerUpdates(section: 0)
            if !updates.isEmpty { handleUpdates(updates) }
        }
    }

    private func setupBindings() {
        inputs.rowViewModels
            .subscribe(onNext: { [weak self] in self?.rowViewModels = $0 })
            .disposed(by: disposeBag)
    }

    private func handleUpdates(_ updates: [Update]) {
        tableView.beginUpdates()
        updates.forEach { update in
            switch update {
            case let .insert(row, section):
                tableView.insertRows(at: [IndexPath(row: row, section: section)], with: .automatic)
            case let .delete(row, section):
                tableView.deleteRows(at: [IndexPath(row: row, section: section)], with: .automatic)
            }
        }
        tableView.endUpdates()
    }

}
