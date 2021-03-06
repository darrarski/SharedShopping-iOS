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

    init(style: UITableViewStyle, inputs: TableViewControllerInputs) {
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
        return rowViewModels[indexPath.row].actions
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
        let row = rowViewModels[indexPath.row]
        row.register(in: tableView)
        return row.cell(at: indexPath, in: tableView)
    }

    // MARK: Private

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
