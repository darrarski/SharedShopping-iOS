import Foundation
@testable import SharedShoppingApp

class ShoppingCreatorSpy: ShoppingCreating {

    var didCreateShopping: Shopping?

    // MARK: ShoppingCreating

    func createShopping() -> Shopping {
        let shopping = Shopping(name: "Shopping", date: Date())
        didCreateShopping = shopping
        return shopping
    }

}
