import RxSwift
import RxCocoa
import RxTest

class MethodCallObserver {

    struct ObservedCall {
        let target: AnyObject
        let selector: Selector
        let parameters: [Any]
    }

    init() {
        scheduler = TestScheduler(initialClock: 0)
        observer = scheduler.createObserver(ObservedCall.self)
    }

    func observe<T: AnyObject & ReactiveCompatible>(_ target: T, _ selector: Selector) {
        target.rx.sentMessage(selector)
            .map { ObservedCall(target: target, selector: selector, parameters: $0) }
            .subscribe(observer)
            .disposed(by: disposeBag)
    }

    var observedCalls: [ObservedCall] {
        return observer.events.flatMap { $0.value.element }
    }

    // MARK: Private

    private let scheduler: TestScheduler
    private let observer: TestableObserver<ObservedCall>
    private let disposeBag = DisposeBag()

}
