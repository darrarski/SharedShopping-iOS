import UIKit

extension Container {

    var appDelegateAssembly: AppDelegateAssembly {
        return Assembly(container: self)
    }

    private struct Assembly: AppDelegateAssembly {

        let container: Container

        // MAKR: AppDelegateAssembly

        var window: UIWindow {
            let window = UIWindow(frame: UIScreen.main.bounds)
            if isRunningTests {
                window.rootViewController = UIViewController(nibName: nil, bundle: nil)
            } else {
                window.rootViewController = container.shoppingsViewController
            }
            return window
        }

        // MARK: Private

        private var isRunningTests: Bool {
            return NSClassFromString("XCTest") != nil
        }
    }

}
