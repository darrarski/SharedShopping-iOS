extension Container {

    var shoppingsTableViewModel: ShoppingsTableViewModel {
        return ShoppingsTableViewModel(
            shoppingsProvider: shoppingService,
            rowViewModelFactory: { self.shoppingsTableRowViewModel(shopping: $0) }
        )
    }

}
