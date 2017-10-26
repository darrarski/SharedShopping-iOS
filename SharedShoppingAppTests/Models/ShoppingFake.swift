import Foundation
@testable import SharedShoppingApp

struct ShoppingFake: Shopping {
    let name: String
    let date: Date

    func isEqual(to other: Shopping) -> Bool {
        return name == other.name &&
               date == other.date
    }
}
