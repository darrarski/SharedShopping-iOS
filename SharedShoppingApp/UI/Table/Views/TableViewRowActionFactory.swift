import UIKit

class TableViewRowActionFactory: TableViewRowActionCreating {

    typealias Factory = (UITableViewRowActionStyle,
                         String?,
                         @escaping (UITableViewRowAction, IndexPath) -> Void) -> UITableViewRowAction

    init(_ create: @escaping Factory = { UITableViewRowAction(style: $0, title: $1, handler: $2) }) {
        self.create = create
    }

    // MARK: TableViewRowActionCreating

    func tableViewRowAction(for action: TableRowAction) -> UITableViewRowAction {
        switch action {
        case let .delete(title, handler): return create(.destructive, title, { (_, _) in handler() })
        }
    }

    // MARK: Private

    private let create: Factory

}
