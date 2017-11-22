import RxSwift

class CreateShoppingViewModel: CreateShoppingViewControllerInputs, CreateShoppingViewControllerOutputs {

    init(shoppingCreator: ShoppingCreating,
         createdShoppingPresenter: CreatedShoppingPresenting) {
        self.shoppingCreator = shoppingCreator
        self.createdShoppingPresenter = createdShoppingPresenter
    }

    // MARK: CreateShoppingViewControllerInputs

    var title: Observable<String?> {
        return Observable.just("Shopping")
    }

    var startEditing: Observable<Void> {
        return startEditingSubject.asObservable()
    }

    var shoppingName: Observable<String?> {
        return shoppingNameVar.asObservable()
    }

    var selectShoppingNameText: Observable<Void> {
        return startEditingSubject.asObservable().single().catchError { _ in Observable.never() }
    }

    var createButtonTitle: Observable<String?> {
        return Observable.just("Create")
    }

    var createButtonEnabled: Observable<Bool> {
        return shoppingNameVar.asObservable().map {
            guard let name = $0 else { return false }
            return !name.isEmpty
        }
    }

    // MARK: CreateShoppingViewControllerOutputs

    func viewDidAppear() {
        startEditingSubject.onNext(())
    }

    func shoppingNameDidChange(_ name: String?) {
        shoppingNameVar.value = name
    }

    func createShopping() {
        let shopping = shoppingCreator.createShopping()
        createdShoppingPresenter.presentCreatedShopping(shopping)
    }

    // MARK: Private

    private let shoppingCreator: ShoppingCreating
    private let createdShoppingPresenter: CreatedShoppingPresenting
    private let startEditingSubject = PublishSubject<Void>()
    private let shoppingNameVar = Variable<String?>("New Shopping")

}
