import UIKit
import Swinject
import SwinjectAutoregistration

class AppAssembly: Assembly {

    func assemble(container: Swinject.Container) {
        container.register(AppWindowCreating.self) { _ in
            AppWindowFactory(size: UIScreen.main.bounds.size)
        }

        if isRunningTests {
            container.register(AppWindowConfiguring.self) { _ in
                TestAppWindowConfigurator()
            }
        } else {
            container.register(AppWindowConfiguring.self) { resolver in
                AppWindowConfigurator(rootViewController: { resolver ~> ShoppingsViewController.self })
            }
        }
    }

    private var isRunningTests: Bool {
        return NSClassFromString("XCTest") != nil
    }

}
