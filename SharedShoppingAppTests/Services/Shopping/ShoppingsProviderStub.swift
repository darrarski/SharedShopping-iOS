@testable import SharedShoppingApp

class ShoppingsProviderStub: ShoppingsProviding {

    var stubShoppings = [Shopping]()

    // MARK: ShoppingsProviding

    func shoppings() -> [Shopping] {
        return stubShoppings
    }

}
