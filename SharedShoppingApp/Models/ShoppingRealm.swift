import RealmSwift

class ShoppingRealm: Object, Shopping {

    // MARK: Shopping

    @objc dynamic var name: String = ""
    @objc dynamic var date: Date = Date()

    func isEqual(to other: Shopping) -> Bool {
        guard let other = other as? ShoppingRealm else { return false }
        return isSameObject(as: other)
    }

}
