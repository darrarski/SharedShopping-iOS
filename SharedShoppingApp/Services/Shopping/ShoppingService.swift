import Foundation

class ShoppingService: ShoppingsProviding, ShoppingCreating, ShoppingRemoving {

    // MARK: ShoppingsProviding

    func shoppings() -> [Shopping] {
        return shoppingsArray
    }

    // MARK: ShoppingCreating

    func createShopping() -> Shopping {
        let shopping = Shopping(name: "New Shopping", date: Date())
        shoppingsArray.append(shopping)
        return shopping
    }

    // MARK: ShoppingRemoving

    func removeShopping(_ shopping: Shopping) {
        guard let index = shoppingsArray.index(of: shopping) else { return }
        shoppingsArray.remove(at: index)
    }

    // MARK: Private

    private var shoppingsArray: [Shopping] = []

}
