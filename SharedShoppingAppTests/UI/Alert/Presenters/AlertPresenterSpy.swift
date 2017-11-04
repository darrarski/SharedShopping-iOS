@testable import SharedShoppingApp

class AlertPresenterSpy: AlertPresenting {

    var didPresentAlert: AlertViewModel?

    // MARK: AlertPresenting

    func presentAlert(_ viewModel: AlertViewModel) {
        didPresentAlert = viewModel
    }

}
