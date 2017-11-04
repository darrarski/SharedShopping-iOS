import Swinject
import SwinjectAutoregistration

class CreateShoppingViewControllerAssembly: Assembly {

    func assemble(container: Container) {
        container.register(CreateShoppingViewController.self) { resolver in
            let viewModel = resolver ~> CreateShoppingViewModel.self
            return CreateShoppingViewController(outputs: viewModel)
        }
    }

}
