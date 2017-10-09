extension Container {

    var shoppingsTableViewModel: ShoppingsTableViewModel {
        return ShoppingsTableViewModel(assembly: Assembly(container: self))
    }

    private struct Assembly: ShoppingsTableViewModelAssembly {

        let container: Container

        // MARK: ShoppingsTableViewModelAssembly

        func tableRowViewModel(shopping: Shopping) -> TableRowViewModel {
            return container.shoppingsTableRowViewModel(shopping: shopping)
        }

    }

}
