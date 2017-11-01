import Swinject

class AppConfiguratorsAssembly: Assembly {

    func assemble(container: Container) {
        if isRunningTests {
            container.register([AppConfiguring].self) { _ in [] }
        } else {
            container.register([AppConfiguring].self) { _ in
                [CrashlyticsConfigurator()]
            }
        }
    }

    private var isRunningTests: Bool {
        return NSClassFromString("XCTest") != nil
    }

}
