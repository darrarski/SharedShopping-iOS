extension Container {

    var shoppingsTableViewModel: ShoppingsTableViewModel {
        return ShoppingsTableViewModel(assembly: Assembly())
    }

    private struct Assembly: ShoppingsTableViewModelAssembly {

        // MARK: ShoppingsTableViewModelAssembly

        func shoppingsTableRowViewModel(shopping: Shopping) -> ShoppingsTableRowViewModel {
            return ShoppingsTableRowViewModel(shopping: shopping)
        }

    }

}
