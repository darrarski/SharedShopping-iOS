import RxSwift
import RxCocoa
import RxTest

class MethodCallObserver<T: AnyObject & ReactiveCompatible> {

    init(target: T, selector: Selector) {
        scheduler = TestScheduler(initialClock: 0)
        observer = scheduler.createObserver([Any].self)
        let observable = target.rx.sentMessage(selector)
        observable.subscribe(observer).disposed(by: disposeBag)
    }

    var observedCalls: [[Any]] {
        return observer.events.flatMap { $0.value.element }
    }

    // MARK: Private

    private let scheduler: TestScheduler
    private let observer: TestableObserver<[Any]>
    private let disposeBag = DisposeBag()

}

extension Reactive where Base: AnyObject & ReactiveCompatible {

    func observeMethodCall(_ selector: Selector) -> MethodCallObserver<Base> {
        return MethodCallObserver(target: self.base, selector: selector)
    }

}
