import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var windowFactory: () -> UIWindow = Container().appWindowFactory

    // MARK: UIApplicationDelegate

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = windowFactory()
        window?.makeKeyAndVisible()
        return true
    }

}
