protocol MutableListType: ListType {
    subscript(index: Int) -> Item { get set }
    func append(_ item: Item)
}

class MutableList<I>: List<I>, MutableListType {

    typealias Item = I

    override subscript(index: Int) -> Item {
        get { fatalError("Abstract subscript") }
        set { fatalError("Abstract subscript") }
    }

    func append(_ item: Item) {
        fatalError("Abstract method")
    }

}
