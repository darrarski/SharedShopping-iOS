import RxSwift

protocol ShoppingsProviding {
    var shoppings: Observable<[Shopping]> { get }
}
