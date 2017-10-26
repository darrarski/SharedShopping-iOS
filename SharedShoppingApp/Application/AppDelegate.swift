import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    override init() {
        let container = Container()
        appWindowFactory = container.appWindowFactory
        appWindowConfigurator = container.appWindowConfiguring
        super.init()
    }

    var appWindowFactory: AppWindowCreating
    var appWindowConfigurator: AppWindowConfiguring

    // MARK: UIApplicationDelegate

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let window = appWindowFactory.createAppWindow()
        appWindowConfigurator.configureWindow(window)
        self.window = window
        return true
    }

}
