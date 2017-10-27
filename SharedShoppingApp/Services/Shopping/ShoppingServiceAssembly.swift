import Swinject
import SwinjectAutoregistration
import RealmSwift

class ShoppingServiceAssembly: Assembly {

    func assemble(container: Container) {
        container.register(ShoppingService.self) { resolver in
            ShoppingServiceRealm(realm: resolver ~> Realm.self)
        }.inObjectScope(.container)
    }

}
