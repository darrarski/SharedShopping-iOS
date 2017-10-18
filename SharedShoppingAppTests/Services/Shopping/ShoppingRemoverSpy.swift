@testable import SharedShoppingApp

class ShoppingRemoverSpy: ShoppingRemoving {

    var didRemoveShopping: Shopping?

    // MARK: ShoppingRemoving

    func removeShopping(_ shopping: Shopping) {
        didRemoveShopping = shopping
    }

}
