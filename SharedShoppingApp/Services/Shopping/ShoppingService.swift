import Foundation
import RxSwift

class ShoppingService: ShoppingsProviding, ShoppingCreating, ShoppingRemoving {

    // MARK: ShoppingsProviding

    var shoppings: Observable<[Shopping]> {
        return shoppingsVar.asObservable()
    }

    // MARK: ShoppingCreating

    func createShopping() -> Shopping {
        let shopping = ShoppingStruct(name: "New Shopping", date: Date())
        shoppingsVar.value.append(shopping)
        return shopping
    }

    // MARK: ShoppingRemoving

    func removeShopping(_ shopping: Shopping) {
        guard let index = shoppingsVar.value.index(where: { $0.isEqual(to: shopping) }) else { return }
        shoppingsVar.value.remove(at: index)
    }

    // MARK: Private

    private var shoppingsVar = Variable<[Shopping]>([])

}
