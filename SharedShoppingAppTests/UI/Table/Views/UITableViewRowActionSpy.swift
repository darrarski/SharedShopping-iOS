import UIKit

class UITableViewRowActionSpy: UITableViewRowAction {

    static func create(style: UITableViewRowActionStyle,
                       title: String?,
                       handler: @escaping (UITableViewRowAction, IndexPath) -> Void) -> UITableViewRowActionSpy {
        let spy = UITableViewRowActionSpy(style: style, title: title, handler: handler)
        spy.handler = handler
        return spy
    }

    private(set) var handler: ((UITableViewRowAction, IndexPath) -> Void)!

}
