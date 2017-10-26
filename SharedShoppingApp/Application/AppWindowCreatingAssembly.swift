import Swinject

class AppWindowCreatingAssembly: Assembly {

    func assemble(container: Container) {
        container.register(AppWindowCreating.self) { _ in
            AppWindowFactory(size: UIScreen.main.bounds.size)
        }
    }

}
