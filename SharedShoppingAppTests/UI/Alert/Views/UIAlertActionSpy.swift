import UIKit

class UIAlertActionSpy: UIAlertAction {

    static func create(title: String?,
                       style: UIAlertActionStyle,
                       handler: ((UIAlertAction) -> Void)?) -> UIAlertActionSpy {
        let spy = UIAlertActionSpy(title: title, style: style, handler: handler)
        spy.handler = handler
        return spy
    }

    private(set) var handler: ((UIAlertAction) -> Void)?

}
