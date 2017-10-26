import UIKit
@testable import SharedShoppingApp

class AppWindowConfiguratorSpy: AppWindowConfiguring {

    var didConfigureWindow: UIWindow?

    // MARK: AppWindowConfiguring

    func configureWindow(_ window: UIWindow) {
        didConfigureWindow = window
    }

}
