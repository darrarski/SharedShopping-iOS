import UIKit

class AppWindowConfigurator: AppWindowConfiguring {

    init(rootViewController: @escaping () -> UIViewController) {
        self.rootViewController = rootViewController
    }

    // MARK: AppWindowConfiguring

    func configureWindow(_ window: UIWindow) {
        window.rootViewController = rootViewController()
        window.makeKeyAndVisible()
    }

    // MARK: Private

    private let rootViewController: () -> UIViewController

}
