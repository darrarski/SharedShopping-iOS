import RxSwift
import RxCocoa
import RxTest

class MethodCallObserver {

    init() {
        scheduler = TestScheduler(initialClock: 0)
        observer = scheduler.createObserver((Selector, [Any]).self)
    }

    func observe<T: AnyObject & ReactiveCompatible>(_ target: T, _ selector: Selector) {
        target.rx.sentMessage(selector)
            .map { (selector, $0) }
            .subscribe(observer)
            .disposed(by: disposeBag)
    }

    var observedCalls: [(Selector, [Any])] {
        return observer.events.flatMap { $0.value.element }
    }

    // MARK: Private

    private let scheduler: TestScheduler
    private let observer: TestableObserver<(Selector, [Any])>
    private let disposeBag = DisposeBag()

}
