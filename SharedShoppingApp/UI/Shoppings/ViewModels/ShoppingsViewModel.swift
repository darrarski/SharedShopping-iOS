protocol ShoppingsViewModelAssembly {

}

class ShoppingsViewModel: ShoppingsViewControllerInputs, ShoppingsViewControllerOutputs {

    init(assembly: ShoppingsViewModelAssembly) {

    }

    // MARK: ShoppingsViewControllerInputs

    let title = "Shared Shopping"

    // MARK: ShoppingsViewControllerOutputs

    func addShopping() {
        // TODO: implement "add shopping" action
    }

}
