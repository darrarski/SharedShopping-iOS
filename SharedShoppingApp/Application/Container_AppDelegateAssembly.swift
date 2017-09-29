import UIKit

extension Container {

    var appDelegateAssembly: AppDelegateAssembly {
        return Assembly()
    }

    private struct Assembly: AppDelegateAssembly {

        var window: UIWindow {
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = ViewController()
            return window
        }

    }

}
