import Swinject
import SwinjectAutoregistration

class AppWindowConfiguringAssembly: Assembly {

    func assemble(container: Container) {
        if isRunningTests {
            container.register(AppWindowConfiguring.self) { _ in
                TestAppWindowConfigurator()
            }
        } else {
            container.register(AppWindowConfiguring.self) { resolver in
                let navigationController = UINavigationController()
                return AppWindowConfigurator(
                    navigationController: { navigationController },
                    rootViewController: { resolver ~> (ShoppingsViewController.self, navigationController) }
                )
            }
        }
    }

    private var isRunningTests: Bool {
        return NSClassFromString("XCTest") != nil
    }

}
