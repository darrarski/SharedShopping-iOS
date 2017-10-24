extension Container {

    var shoppingsViewModel: ShoppingsViewModel {
        return ShoppingsViewModel(shoppingCreator: shoppingService)
    }

}
