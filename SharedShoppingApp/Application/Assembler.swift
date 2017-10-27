import Swinject

extension Assembler {

    static var `default`: Assembler {
        return Assembler([
            AppWindowCreatingAssembly(),
            AppWindowConfiguringAssembly(),
            RealmAssembly(),
            ShoppingServiceAssembly(),
            ShoppingsViewControllerAssembly(),
            ShoppingsViewModelAssembly(),
            ShoppingsTableViewModelAssembly(),
            ShoppingsTableRowViewModelAssembly()
        ])
    }

}
