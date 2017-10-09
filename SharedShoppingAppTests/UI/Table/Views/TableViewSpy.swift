import UIKit

class TableViewSpy: UITableView {

    init() {
        super.init(frame: .zero, style: .plain)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var cellStub: (String) -> UITableViewCell = { UITableViewCell(style: .default, reuseIdentifier: $0) }

    var registerCellClassForCellReuseIdentifierCalled: (AnyClass?, String)?
    var dequeueReusableCellWithIdentifierForIndexPathCalled: (String, IndexPath)?

    // MARK: UITableView

    override func register(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {
        registerCellClassForCellReuseIdentifierCalled = (cellClass, identifier)
    }

    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        dequeueReusableCellWithIdentifierForIndexPathCalled = (identifier, indexPath)
        return cellStub(identifier)
    }

}
