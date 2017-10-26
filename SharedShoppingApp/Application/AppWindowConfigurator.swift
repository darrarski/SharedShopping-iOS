import UIKit

class AppWindowConfigurator: AppWindowConfiguring {

    init(rootViewController: @escaping () -> UIViewController) {
        self.rootViewController = rootViewController
    }

    // MARK: AppWindowConfiguring

    func configureWindow(_ window: UIWindow) {
        let navigationController = UINavigationController(rootViewController: rootViewController())
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    // MARK: Private

    private let rootViewController: () -> UIViewController

}
