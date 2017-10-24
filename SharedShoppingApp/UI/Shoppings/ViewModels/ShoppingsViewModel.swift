class ShoppingsViewModel: ShoppingsViewControllerInputs, ShoppingsViewControllerOutputs {

    init(shoppingCreator: ShoppingCreating) {
        self.shoppingCreator = shoppingCreator
    }

    // MARK: ShoppingsViewControllerInputs

    let title = "Shared Shopping"

    // MARK: ShoppingsViewControllerOutputs

    func addShopping() {
        _ = shoppingCreator.createShopping()
    }

    // MARK: Private

    private let shoppingCreator: ShoppingCreating

}
