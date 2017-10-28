import Foundation

struct ShoppingStruct: Shopping {
    let name: String
    let date: Date

    func isEqual(to other: Shopping) -> Bool {
        guard let other = other as? ShoppingStruct else { return false }
        return name == other.name &&
               date == other.date
    }
}
