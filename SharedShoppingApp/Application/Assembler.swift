import Swinject

extension Assembler {

    static var `default`: Assembler {
        return Assembler([
            AppConfiguratorsAssembly(),
            AppWindowCreatingAssembly(),
            AppWindowConfiguringAssembly(),
            RealmAssembly(),
            ShoppingServiceAssembly(),
            ShoppingNavigatorAssembly(),
            ShoppingsViewControllerAssembly(),
            ShoppingsViewModelAssembly(),
            ShoppingsTableViewModelAssembly(),
            ShoppingsTableRowViewModelAssembly(),
            ShoppingViewControllerAssembly()
        ])
    }

}
