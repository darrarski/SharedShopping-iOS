import Foundation
@testable import SharedShoppingApp

class ShoppingCreatorSpy: ShoppingCreating {

    var didCreateShopping: Shopping?

    // MARK: ShoppingCreating

    func createShopping() -> Shopping {
        let shopping = ShoppingFake(name: "Shopping", date: Date())
        didCreateShopping = shopping
        return shopping
    }

}
