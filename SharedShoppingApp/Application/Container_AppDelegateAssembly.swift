import UIKit

extension Container {

    var appDelegateAssembly: AppDelegateAssembly {
        if let stubClass = NSClassFromString("SharedShoppingAppTests.AppDelegateAssemblyStub") as? NSObject.Type,
            let stubInstance = stubClass.init() as? AppDelegateAssembly {
            return stubInstance
        }
        return Assembly(container: self)
    }

    private struct Assembly: AppDelegateAssembly {

        let container: Container

        // MAKR: AppDelegateAssembly

        var window: UIWindow {
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = container.shoppingsViewController
            return window
        }

    }

}
