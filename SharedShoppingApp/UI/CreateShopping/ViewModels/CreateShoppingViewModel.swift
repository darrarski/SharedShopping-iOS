class CreateShoppingViewModel: CreateShoppingViewControllerOutputs {

    init(shoppingCreator: ShoppingCreating) {
        self.shoppingCreator = shoppingCreator
    }

    // MARK: CreateShoppingViewControllerOutputs

    func createShopping() {
        _ = shoppingCreator.createShopping()
    }

    // MARK: Private

    private let shoppingCreator: ShoppingCreating

}
