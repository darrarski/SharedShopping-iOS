import CoreGraphics

protocol TableRowViewModel {
    static var cellIdentifier: String { get }
    var estimatedHeight: CGFloat { get }
    var height: CGFloat { get }
    var actions: [TableRowAction]? { get }
    func isEqual(to other: TableRowViewModel) -> Bool
    func didSelect()
}
