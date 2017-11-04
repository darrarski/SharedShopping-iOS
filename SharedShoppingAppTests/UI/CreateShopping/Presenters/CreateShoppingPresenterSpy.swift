@testable import SharedShoppingApp

class CreateShoppingPresenterSpy: CreateShoppingPresenting {

    var didPresentCreateShopping = false

    // MARK: CreateShoppingPresenting

    func presentCreateShopping() {
        didPresentCreateShopping = true
    }

}
