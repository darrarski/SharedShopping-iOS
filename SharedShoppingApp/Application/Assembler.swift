import Swinject

extension Assembler {

    static var `default`: Assembler {
        return Assembler([
            AppWindowCreatingAssembly(),
            AppWindowConfiguringAssembly(),
            ShoppingServiceAssembly(),
            ShoppingsViewControllerAssembly(),
            ShoppingsViewModelAssembly(),
            ShoppingsTableViewModelAssembly(),
            ShoppingsTableRowViewModelAssembly()
        ])
    }

}
