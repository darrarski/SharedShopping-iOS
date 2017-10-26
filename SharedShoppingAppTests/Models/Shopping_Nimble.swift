import Nimble
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
