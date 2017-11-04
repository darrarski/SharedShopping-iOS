class ShoppingsViewModel: ShoppingsViewControllerInputs, ShoppingsViewControllerOutputs {

    init(createShoppingPresenter: CreateShoppingPresenting) {
        self.createShoppingPresenter = createShoppingPresenter
    }

    // MARK: ShoppingsViewControllerInputs

    let title = "Shared Shopping"

    // MARK: ShoppingsViewControllerOutputs

    func addShopping() {
        createShoppingPresenter.presentCreateShopping()
    }

    // MARK: Private

    private let createShoppingPresenter: CreateShoppingPresenting

}
