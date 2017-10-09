import UIKit

protocol TableViewControllerInputs {
    func numberOfRows(in section: Int) -> Int
    func row(at indexPath: IndexPath) -> TableRowViewModel
}

class TableViewController: UITableViewController {

    init(style: UITableViewStyle, inputs: TableViewControllerInputs) {
        self.inputs = inputs
        super.init(style: style)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: UITableViewDelegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return inputs.row(at: indexPath).height(at: indexPath)
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return inputs.row(at: indexPath).estimatedHeight(at: indexPath)
    }

    // MARK: UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inputs.numberOfRows(in: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = inputs.row(at: indexPath)
        row.register(in: tableView)
        return row.cell(at: indexPath, in: tableView)
    }

    // MARK: Private

    private let inputs: TableViewControllerInputs

}
