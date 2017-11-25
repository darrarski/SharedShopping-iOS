import RxSwift

class ShoppingsViewModel: ShoppingsViewControllerInputs, ShoppingsViewControllerOutputs {

    init(createShoppingPresenter: CreateShoppingPresenting) {
        self.createShoppingPresenter = createShoppingPresenter
    }

    // MARK: ShoppingsViewControllerInputs

    var title: Observable<String?> {
        return Observable.just("Shared Shopping")
    }

    // MARK: ShoppingsViewControllerOutputs

    func addShopping() {
        createShoppingPresenter.presentCreateShopping()
    }

    // MARK: Private

    private let createShoppingPresenter: CreateShoppingPresenting

}
