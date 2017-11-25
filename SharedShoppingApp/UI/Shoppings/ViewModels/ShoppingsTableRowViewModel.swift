import UIKit

class ShoppingsTableRowViewModel: TableRowViewModel {

    init(dateFormatter: DateFormatter,
         shoppingRemover: ShoppingRemoving,
         shoppingPresenter: ShoppingPresenting,
         alertPresenter: AlertPresenting,
         shopping: Shopping) {
        self.dateFormatter = dateFormatter
        self.shoppingRemover = shoppingRemover
        self.shoppingPresenter = shoppingPresenter
        self.alertPresenter = alertPresenter
        self.shopping = shopping
    }

    var title: String {
        return shopping.name
    }

    var subtitle: String {
        return dateFormatter.string(from: shopping.date)
    }

    // MARK: TableRowViewModel

    static var cellIdentifier: String {
        return "shopping"
    }

    var estimatedHeight: CGFloat {
        return 60
    }

    var height: CGFloat {
        return UITableViewAutomaticDimension
    }

    var actions: [TableRowAction]? {
        return [.delete(title: "Delete", handler: { [weak self] in self?.handleDeleteAction() })]
    }

    func isEqual(to other: TableRowViewModel) -> Bool {
        guard let other = other as? ShoppingsTableRowViewModel else { return false }
        return shopping.isEqual(to: other.shopping)
    }

    func didSelect() {
        shoppingPresenter.presentShopping(shopping)
    }

    // MARK: Private

    private let dateFormatter: DateFormatter
    private let shoppingRemover: ShoppingRemoving
    private let shoppingPresenter: ShoppingPresenting
    private let alertPresenter: AlertPresenting
    private let shopping: Shopping

    private func handleDeleteAction() {
        let viewModel = AlertViewModel(
            title: "Delete Shopping",
            message: "Are you sure you want to delete selected Shopping with all contained data?",
            actions: [
                AlertActionViewModel(
                    title: "Cancel",
                    style: .cancel,
                    handler: {}
                ),
                AlertActionViewModel(
                    title: "Delete",
                    style: .destruct,
                    handler: { [weak self] in self?.deleteShopping() }
                )
            ]
        )
        alertPresenter.presentAlert(viewModel)
    }

    private func deleteShopping() {
        shoppingRemover.removeShopping(shopping)
    }

}
