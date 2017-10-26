import UIKit
@testable import SharedShoppingApp

class AppWindowFactoryStub: AppWindowCreating {

    let windowSpy = UIWindowSpy()

    // MARK: AppWindowCreating

    func createAppWindow() -> UIWindow {
        return windowSpy
    }

}
