import Swinject
import SwinjectAutoregistration
import Crashlytics

class AppConfiguratorsAssembly: Assembly {

    func assemble(container: Container) {
        container.register([AppConfiguring].self) { resolver in
            let isRunningTests = NSClassFromString("XCTest") != nil
            guard !isRunningTests else { return [] }
            return [
                resolver ~> CrashlyticsConfigurator.self
            ]
        }
        container.register(CrashlyticsConfigurator.self) { _ in
            CrashlyticsConfigurator(
                // swiftlint:disable:next force_unwrapping
                apiKeyURL: Bundle.main.url(forResource: "fabric", withExtension: "apikey")!,
                start: { Crashlytics.start(withAPIKey: $0) }
            )
        }
    }

}
