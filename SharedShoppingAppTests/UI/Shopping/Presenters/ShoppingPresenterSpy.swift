@testable import SharedShoppingApp

class ShoppingPresenterSpy: ShoppingPresenting {

    var didPresentShopping: Shopping?

    // MARK: ShoppingPresenting

    func presentShopping(_ shopping: Shopping) {
        didPresentShopping = shopping
    }

}
