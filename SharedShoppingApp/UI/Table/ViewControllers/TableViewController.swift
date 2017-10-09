import UIKit

protocol TableViewControllerInputs {
    func numberOfRows(in section: Int) -> Int
    func rowViewModel(at indexPath: IndexPath) -> TableRowViewModel
}

class TableViewController: UITableViewController {

    init(style: UITableViewStyle, inputs: TableViewControllerInputs) {
        self.inputs = inputs
        super.init(style: style)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return inputs.rowViewModel(at: indexPath).height
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return inputs.rowViewModel(at: indexPath).estimatedHeight
    }

    override func tableView(_ tableView: UITableView,
                            editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return inputs.rowViewModel(at: indexPath).actions
    }

    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inputs.numberOfRows(in: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = inputs.rowViewModel(at: indexPath)
        row.register(in: tableView)
        return row.cell(at: indexPath, in: tableView)
    }

    // MARK: Private

    private let inputs: TableViewControllerInputs

}
