import Foundation
@testable import SharedShoppingApp

class ShoppingCreatorSpy: ShoppingCreating {

    var didCreateShopping: Shopping?

    // MARK: ShoppingCreating

    func createShopping(name: String) -> Shopping {
        let shopping = ShoppingFake(name: name, date: Date())
        didCreateShopping = shopping
        return shopping
    }

}
