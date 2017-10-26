import Foundation

protocol Shopping {
    var name: String { get }
    var date: Date { get }
    func isEqual(to other: Shopping) -> Bool
}
