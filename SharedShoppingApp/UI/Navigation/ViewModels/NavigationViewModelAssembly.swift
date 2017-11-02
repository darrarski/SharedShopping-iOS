import Swinject

class NavigationViewModelAssembly: Assembly {

    func assemble(container: Container) {
        container.register(NavigationViewModel.self) { _ in
            return NavigationViewModel()
        }
    }

}
