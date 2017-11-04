import Swinject

class CreateShoppingViewControllerAssembly: Assembly {

    func assemble(container: Container) {
        container.register(CreateShoppingViewController.self) { _ in
            CreateShoppingViewController()
        }
    }

}
