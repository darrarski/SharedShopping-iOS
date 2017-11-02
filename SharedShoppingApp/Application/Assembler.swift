import Swinject

extension Assembler {

    static var `default`: Assembler {
        return Assembler([
            AppConfiguratorsAssembly(),
            AppWindowCreatingAssembly(),
            AppWindowConfiguringAssembly(),
            RealmAssembly(),
            ShoppingServiceAssembly(),
            NavigationViewControllerAssembly(),
            ShoppingsViewControllerAssembly(),
            ShoppingsViewModelAssembly(),
            ShoppingsTableViewModelAssembly(),
            ShoppingsTableRowViewModelAssembly(),
            ShoppingViewControllerAssembly()
        ])
    }

}
