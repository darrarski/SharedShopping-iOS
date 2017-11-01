import UIKit
import Swinject
import SwinjectAutoregistration

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    override init() {
        assembler = Assembler.default
        appConfigurators = assembler.resolver ~> [AppConfiguring].self
        appWindowFactory = assembler.resolver ~> AppWindowCreating.self
        appWindowConfigurator = assembler.resolver ~> AppWindowConfiguring.self
        super.init()
    }

    let assembler: Assembler
    var appConfigurators: [AppConfiguring]
    var appWindowFactory: AppWindowCreating
    var appWindowConfigurator: AppWindowConfiguring

    // MARK: UIApplicationDelegate

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        appConfigurators.forEach { $0.configure() }
        let window = appWindowFactory.createAppWindow()
        appWindowConfigurator.configureWindow(window)
        self.window = window
        return true
    }

}
