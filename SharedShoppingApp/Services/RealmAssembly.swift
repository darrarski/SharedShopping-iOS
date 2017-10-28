import Swinject
import RealmSwift

class RealmAssembly: Assembly {

    func assemble(container: Container) {
        container.register(Realm.self) { _ in
            try! Realm() // swiftlint:disable:this force_try
        }
    }

}
