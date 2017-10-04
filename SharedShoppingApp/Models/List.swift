import RxSwift

protocol ListType {
    associatedtype Item
    subscript(index: Int) -> Item { get }
    var numberOfItems: Int { get }
}

class List<I>: ListType {

    typealias Item = I

    subscript(index: Int) -> Item {
        get { fatalError("Abstract subscript") }
    }

    var numberOfItems: Int {
        fatalError("Abstract property")
    }

}
