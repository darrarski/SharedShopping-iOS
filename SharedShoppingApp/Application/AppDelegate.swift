import UIKit

protocol AppDelegateAssembly {
    var window: UIWindow { get }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var assembly: AppDelegateAssembly = Container().appDelegateAssembly

    // MARK: UIApplicationDelegate

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = assembly.window
        window?.makeKeyAndVisible()
        return true
    }

}
