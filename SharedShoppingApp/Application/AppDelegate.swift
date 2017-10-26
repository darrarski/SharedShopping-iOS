import UIKit
import Swinject
import SwinjectAutoregistration

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    override init() {
        assembler = Assembler.default
        appWindowFactory = assembler.resolver ~> AppWindowCreating.self
        appWindowConfigurator = assembler.resolver ~> AppWindowConfiguring.self
        super.init()
    }

    let assembler: Assembler
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
