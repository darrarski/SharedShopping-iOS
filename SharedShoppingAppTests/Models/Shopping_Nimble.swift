import Nimble
import RxSwift
import RxTest
@testable import SharedShoppingApp

func equal(_ expected: Shopping) -> Predicate<Shopping> {
    return Predicate.simple("equal <\(expected)>") {
        guard let actual = try $0.evaluate() else { return .fail }
        return PredicateStatus(bool: actual.isEqual(to: expected))
    }
}

func equal(_ expected: Shopping?) -> Predicate<Shopping?> {
    let expectedDescription = expected == nil ? "nil" : "\(expected!)"
    return Predicate.simple("equal <\(expectedDescription)>") {
        guard let actual = try $0.evaluate() else { return .fail }
        switch (actual, expected) {
        case (.none, .none): return PredicateStatus.matches
        case (.some, .none), (.none, .some): return PredicateStatus.doesNotMatch
        case let (.some(actual), .some(expected)): return PredicateStatus(bool: actual.isEqual(to: expected))
        }
    }
}

func contain(_ item: Shopping) -> Predicate<[Shopping]> {
    return Predicate.simple("contain <\(item)>") {
        guard let actual = try $0.evaluate() else { return .fail }
        return PredicateStatus(bool: actual.contains(where: { $0.isEqual(to: item) }))
    }
}

func equal(_ expectation: [Shopping]) -> Predicate<[Shopping]> {
    return Predicate.simple("equal <\(expectation)>") {
        guard let actual = try $0.evaluate() else { return .fail }
        guard actual.count == expectation.count else { return .fail }
        let result = actual.elementsEqual(expectation) { $0.isEqual(to: $1) }
        return PredicateStatus(bool: result)
    }
}

func equal(_ expectation: Recorded<Event<[Shopping]>>) -> Predicate<Recorded<Event<[Shopping]>>> {
    return Predicate.simple("equal <\(expectation)>") {
        guard let actual = try $0.evaluate() else { return .fail }
        guard actual.time == expectation.time else { return .doesNotMatch }
        switch (actual.value, expectation.value) {
        case let (.next(actualValue), .next(expectedValue)):
            return PredicateStatus(bool: actualValue.elementsEqual(expectedValue) { $0.isEqual(to: $1) })
        case let (.error(actualError), .error(expectedError)):
            return PredicateStatus(bool: (actualError as NSError) == (expectedError as NSError))
        case (.completed, .completed):
            return .matches
        default:
            return .doesNotMatch
        }
    }
}

func equal(_ expectation: [Recorded<Event<[Shopping]>>]) -> Predicate<[Recorded<Event<[Shopping]>>]> {
    return Predicate.simple("equal <\(expectation)>") {
        guard let actual = try $0.evaluate() else { return .fail }
        guard actual.count == expectation.count else { return .fail }
        let result = actual.elementsEqual(expectation) { actualRecord, expectedRecord in
            guard actualRecord.time == expectedRecord.time else { return false }
            switch (actualRecord.value, expectedRecord.value) {
            case let (.next(actualValue), .next(expectedValue)):
                return actualValue.elementsEqual(expectedValue) { $0.isEqual(to: $1) }
            case let (.error(actualError), .error(expectedError)):
                return (actualError as NSError) == (expectedError as NSError)
            case (.completed, .completed):
                return true
            default:
                return false
            }
        }
        return PredicateStatus(bool: result)
    }
}
