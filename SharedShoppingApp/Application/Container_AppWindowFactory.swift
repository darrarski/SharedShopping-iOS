import UIKit

extension Container {

    var appWindowFactory: () -> UIWindow {
        return {
            let window = UIWindow(frame: UIScreen.main.bounds)
            if self.isRunningTests {
                window.rootViewController = UIViewController(nibName: nil, bundle: nil)
            } else {
                let shoppingsViewController = self.shoppingsViewController
                let navigationController = UINavigationController(rootViewController: shoppingsViewController)
                window.rootViewController = navigationController
            }
            return window
        }
    }

    private var isRunningTests: Bool {
        return NSClassFromString("XCTest") != nil
    }

}
