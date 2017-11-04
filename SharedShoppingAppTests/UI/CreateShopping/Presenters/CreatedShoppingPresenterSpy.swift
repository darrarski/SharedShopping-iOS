@testable import SharedShoppingApp

class CreatedShoppingPresenterSpy: CreatedShoppingPresenting {

    var didPresentCreatedShopping: Shopping?

    // MARK: CreateShoppingPresenting

    func presentCreatedShopping(_ shopping: Shopping) {
        didPresentCreatedShopping = shopping
    }

}
