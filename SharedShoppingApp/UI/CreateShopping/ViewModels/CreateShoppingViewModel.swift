class CreateShoppingViewModel: CreateShoppingViewControllerOutputs {

    init(shoppingCreator: ShoppingCreating,
         createdShoppingPresenter: CreatedShoppingPresenting) {
        self.shoppingCreator = shoppingCreator
        self.createdShoppingPresenter = createdShoppingPresenter
    }

    // MARK: CreateShoppingViewControllerOutputs

    func viewDidAppear() {
        // TODO:
    }

    func createShopping() {
        let shopping = shoppingCreator.createShopping()
        createdShoppingPresenter.presentCreatedShopping(shopping)
    }

    // MARK: Private

    private let shoppingCreator: ShoppingCreating
    private let createdShoppingPresenter: CreatedShoppingPresenting

}
