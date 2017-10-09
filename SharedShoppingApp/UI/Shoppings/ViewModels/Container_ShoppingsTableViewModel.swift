extension Container {

    var shoppingsTableViewModel: ShoppingsTableViewModel {
        return ShoppingsTableViewModel(assembly: Assembly(container: self))
    }

    private struct Assembly: ShoppingsTableViewModelAssembly {

        let container: Container

        // MARK: ShoppingsTableViewModelAssembly

        func shoppingsTableRowViewModel(shopping: Shopping) -> ShoppingsTableRowViewModel {
            return container.shoppingsTableRowViewModel(shopping: shopping)
        }

    }

}
