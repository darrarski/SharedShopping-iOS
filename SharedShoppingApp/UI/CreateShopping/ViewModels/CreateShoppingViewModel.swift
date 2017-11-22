import RxSwift

class CreateShoppingViewModel: CreateShoppingViewControllerInputs, CreateShoppingViewControllerOutputs {

    init(shoppingCreator: ShoppingCreating,
         createdShoppingPresenter: CreatedShoppingPresenting) {
        self.shoppingCreator = shoppingCreator
        self.createdShoppingPresenter = createdShoppingPresenter
    }

    // MARK: CreateShoppingViewControllerInputs

    var title: String {
        return "Shopping"
    }

    var startEditing: Observable<Void> {
        return startEditingSubject.asObservable()
    }

    var shoppingName: Observable<String?> {
        return Observable.just("New Shopping") // TODO:
    }

    var selectShoppingNameText: Observable<Void> {
        return startEditingSubject.asObservable().single().catchError { _ in Observable.never() }
    }

    // MARK: CreateShoppingViewControllerOutputs

    func viewDidAppear() {
        startEditingSubject.onNext(())
    }

    func createShopping() {
        let shopping = shoppingCreator.createShopping()
        createdShoppingPresenter.presentCreatedShopping(shopping)
    }

    // MARK: Private

    private let shoppingCreator: ShoppingCreating
    private let createdShoppingPresenter: CreatedShoppingPresenting
    private let startEditingSubject = PublishSubject<Void>()

}
