import Foundation
import RxSwift
import RealmSwift
import RxRealm

class ShoppingServiceRealm: ShoppingsProviding, ShoppingCreating, ShoppingRemoving {

    init(realm: Realm) {
        self.realm = realm
    }

    // MARK: ShoppingsProviding

    var shoppings: Observable<[Shopping]> {
        let objects = realm.objects(ShoppingRealm.self).sorted(byKeyPath: "date")
        return Observable.collection(from: objects).map { $0.toArray() }
    }

    // MARK: ShoppingCreating

    func createShopping(name: String) -> Shopping {
        let shopping = ShoppingRealm()
        shopping.name = name
        shopping.date = Date()
        try! realm.write { // swiftlint:disable:this force_try
            realm.add(shopping)
        }
        return shopping
    }

    // MARK: ShoppingRemoving

    func removeShopping(_ shopping: Shopping) {
        guard let shopping = shopping as? ShoppingRealm else { return }
        try! realm.write { // swiftlint:disable:this force_try
            realm.delete(shopping)
        }
    }

    // MARK: Private

    private let realm: Realm

}
