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
                return AppWindowConfigurator(
                    navigationController: { UINavigationController() },
                    rootViewController: { resolver ~> ShoppingsViewController.self }
                )
            }
        }
    }

    private var isRunningTests: Bool {
        return NSClassFromString("XCTest") != nil
    }

}
