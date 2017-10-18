protocol ShoppingsViewModelAssembly {
    var shoppingCreator: ShoppingCreating { get }
}

class ShoppingsViewModel: ShoppingsViewControllerInputs, ShoppingsViewControllerOutputs {

    init(assembly: ShoppingsViewModelAssembly) {
        shoppingCreator = assembly.shoppingCreator
    }

    // MARK: ShoppingsViewControllerInputs

    let title = "Shared Shopping"

    // MARK: ShoppingsViewControllerOutputs

    func addShopping() {
        _ = shoppingCreator.createShopping()
    }

    // MARK: Private

    private let shoppingCreator: ShoppingCreating

}
