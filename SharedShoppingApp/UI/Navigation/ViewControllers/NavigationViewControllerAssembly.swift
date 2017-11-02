import Swinject
import SwinjectAutoregistration

class NavigationViewControllerAssembly: Assembly {

    func assemble(container: Container) {
        container.register(NavigationViewController.self) { resolver in
            let viewModel = resolver ~> NavigationViewModel.self
            return NavigationViewController(
                navigationController: UINavigationController(),
                inputs: viewModel
            )
        }
    }

}
