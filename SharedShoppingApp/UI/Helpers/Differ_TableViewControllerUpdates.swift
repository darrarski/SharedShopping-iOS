import Differ

extension Sequence where Iterator.Element == Diff.Element {

    func tableViewControllerUpdates(section: Int) -> [TableViewController.Update] {
        return map { element -> TableViewController.Update in
            switch element {
            case .insert(let index):
                return .insert(row: index, inSection: 0)
            case .delete(let index):
                return .delete(row: index, inSection: 0)
            }
        }
    }

}
