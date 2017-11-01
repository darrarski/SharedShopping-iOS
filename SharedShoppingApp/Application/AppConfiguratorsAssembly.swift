import Swinject

class AppConfiguratorsAssembly: Assembly {

    func assemble(container: Container) {
        container.register([AppConfiguring].self) { _ in [
            CrashlyticsConfigurator()
        ]}
    }

}
