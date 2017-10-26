import Foundation

extension Container {

    var appWindowConfiguring: AppWindowConfiguring {
        if isRunningTests {
            return TestAppWindowConfigurator()
        } else {
            return AppWindowConfigurator(rootViewController: { self.shoppingsViewController })
        }
    }

    private var isRunningTests: Bool {
        return NSClassFromString("XCTest") != nil
    }

}
