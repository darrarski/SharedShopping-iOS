import Swinject
import SwinjectAutoregistration

class AlertPresenterAssembly: Assembly {

    func assemble(container: Container) {
        container.register(AlertPresenter.self) { resolver, parentViewController in
            AlertPresenter(
                parentViewController: parentViewController,
                alertViewControllerFactory: resolver ~> AlertViewControllerFactory.self
            )
        }
    }

}
