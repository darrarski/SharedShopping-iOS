import Nimble
import RxSwift
import RxTest

class SimpleTestableObserver<T> {

    init() {
        scheduler = TestScheduler(initialClock: 0)
        testableObserver = scheduler.createObserver(T.self)
    }

    var observer: AnyObserver<T> {
        return testableObserver.asObserver()
    }

    var events: [Event<T>] {
        return testableObserver.events.map { $0.value }
    }

    // MARK: Private

    private let scheduler: TestScheduler
    private let testableObserver: TestableObserver<T>

}

func equal<T: Equatable>(_ expected: Event<T>) -> Predicate<Event<T>> {
    return Predicate.simple("equal <\(expected)>") {
        guard let actual = try $0.evaluate() else { return .fail }
        switch (actual, expected) {
        case (.next, .next), (.completed, .completed):
            return PredicateStatus.matches
        case let (.error(lhs), .error(rhs)):
            return PredicateStatus(bool: (lhs as NSError) == (rhs as NSError))
        default:
            return PredicateStatus.doesNotMatch
        }
    }
}

func equal<T: Equatable>(_ expected: [Event<T>]) -> Predicate<[Event<T>]> {
    return Predicate.simple("equal <\(expected)>") {
        guard let actual = try $0.evaluate() else { return .fail }
        guard actual.count == expected.count else {
            return PredicateStatus.doesNotMatch
        }
        for (index, actual) in actual.enumerated() {
            let expected = expected[index]
            switch (actual, expected) {
            case let (.next(lhs), .next(rhs)):
                if lhs != rhs {
                    return PredicateStatus.doesNotMatch
                }
            case (.completed, .completed):
                continue
            case let (.error(lhs), .error(rhs)):
                return PredicateStatus(bool: (lhs as NSError) == (rhs as NSError))
            default:
                return PredicateStatus.doesNotMatch
            }
        }
        return PredicateStatus.matches
    }
}

func equal(_ expected: Event<Void>) -> Predicate<Event<Void>> {
    return Predicate.simple("equal <\(expected)>") {
        guard let actual = try $0.evaluate() else { return .fail }
        switch (actual, expected) {
        case (.next, .next), (.completed, .completed):
            return PredicateStatus.matches
        case let (.error(lhs), .error(rhs)):
            return PredicateStatus(bool: (lhs as NSError) == (rhs as NSError))
        default:
            return PredicateStatus.doesNotMatch
        }
    }
}

func equal(_ expected: [Event<Void>]) -> Predicate<[Event<Void>]> {
    return Predicate.simple("equal <\(expected)>") {
        guard let actual = try $0.evaluate() else { return .fail }
        guard actual.count == expected.count else {
            return PredicateStatus.doesNotMatch
        }
        for (index, actual) in actual.enumerated() {
            let expected = expected[index]
            switch (actual, expected) {
            case (.next, .next), (.completed, .completed):
                continue
            case let (.error(lhs), .error(rhs)):
                return PredicateStatus(bool: (lhs as NSError) == (rhs as NSError))
            default:
                return PredicateStatus.doesNotMatch
            }
        }
        return PredicateStatus.matches
    }
}
