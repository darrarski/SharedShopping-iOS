@testable import SharedShoppingApp

class ShoppingNavigatorSpy: ShoppingNavigating {

    var didNavigateToShopping: Shopping?

    // MARK: ShoppingNavigating

    func navigateToShopping(_ shopping: Shopping) {
        didNavigateToShopping = shopping
    }

}
