import Swinject

class ShoppingServiceAssembly: Assembly {

    func assemble(container: Container) {
        container.register(ShoppingService.self) { _ in
            ShoppingServiceRealm()
        }.inObjectScope(.container)
    }

}
