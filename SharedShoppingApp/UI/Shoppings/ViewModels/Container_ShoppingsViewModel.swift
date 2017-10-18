extension Container {

    var shoppingsViewModel: ShoppingsViewModel {
        return ShoppingsViewModel(assembly: Assembly(container: self))
    }

    private struct Assembly: ShoppingsViewModelAssembly {

        let container: Container

        // MARK: ShoppingsViewModelAssembly

        var shoppingCreator: ShoppingCreating {
            return container.shoppingService
        }

    }

}
