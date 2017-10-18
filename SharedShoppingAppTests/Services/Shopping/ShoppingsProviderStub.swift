import RxSwift
@testable import SharedShoppingApp

class ShoppingsProviderStub: ShoppingsProviding {

    let shoppingsVar = Variable<[Shopping]>([])

    // MARK: ShoppingsProviding

    var shoppings: Observable<[Shopping]> {
        return shoppingsVar.asObservable()
    }

}
