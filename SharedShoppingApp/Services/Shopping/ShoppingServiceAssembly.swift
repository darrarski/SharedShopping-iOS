import Swinject

class ShoppingServiceAssembly: Assembly {

    func assemble(container: Swinject.Container) {
        container.register(ShoppingService.self) { _ in
            ShoppingService()
        }.inObjectScope(.container)
    }

}
