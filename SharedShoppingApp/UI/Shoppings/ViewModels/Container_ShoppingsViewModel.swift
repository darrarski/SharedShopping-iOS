extension Container {

    var shoppingsViewModel: ShoppingsViewModel {
        return ShoppingsViewModel(assembly: Assembly())
    }

    private struct Assembly: ShoppingsViewModelAssembly {

    }

}
