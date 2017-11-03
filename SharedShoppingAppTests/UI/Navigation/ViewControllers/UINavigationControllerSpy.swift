import UIKit

class UINavigationControllerSpy: UINavigationController {

    var didPushViewController: UIViewController?

    // MARK: UINavigationController

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        didPushViewController = viewController
    }

}
