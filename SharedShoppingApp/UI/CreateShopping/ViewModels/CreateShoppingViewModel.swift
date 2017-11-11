import RxSwift

class CreateShoppingViewModel: CreateShoppingViewControllerInputs, CreateShoppingViewControllerOutputs {

    init(shoppingCreator: ShoppingCreating,
         createdShoppingPresenter: CreatedShoppingPresenting) {
        self.shoppingCreator = shoppingCreator
        self.createdShoppingPresenter = createdShoppingPresenter
    }

    // MARK: CreateShoppingViewControllerInputs

    var startEditing: Observable<Void> {
        return Observable.never() // TODO:
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
