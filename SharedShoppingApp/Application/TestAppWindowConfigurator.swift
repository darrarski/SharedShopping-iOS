import UIKit

class TestAppWindowConfigurator: AppWindowConfiguring {

    // MARK: AppWindowConfiguring

    func configureWindow(_ window: UIWindow) {
        window.rootViewController = UIViewController(nibName: nil, bundle: nil)
        window.makeKeyAndVisible()
    }

}
