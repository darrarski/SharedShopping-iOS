import Swinject

class AlertViewControllerFactoryAssembly: Assembly {

    func assemble(container: Container) {
        container.register(AlertViewControllerFactory.self) { _ in
            AlertViewControllerFactory(actionFactory: { title, style, handler in
                UIAlertAction(title: title, style: style, handler: handler)
            })
        }
    }

}
