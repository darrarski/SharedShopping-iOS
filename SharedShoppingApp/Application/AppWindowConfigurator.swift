import UIKit

class AppWindowConfigurator: AppWindowConfiguring {

    init(navigationController: @escaping () -> UINavigationController,
         rootViewController: @escaping () -> UIViewController) {
        self.navigationController = navigationController
        self.rootViewController = rootViewController
    }

    // MARK: AppWindowConfiguring

    func configureWindow(_ window: UIWindow) {
        let navigationController = self.navigationController()
        let rootViewController = self.rootViewController()
        navigationController.viewControllers = [rootViewController]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

    // MARK: Private

    private let navigationController: () -> UINavigationController
    private let rootViewController: () -> UIViewController

}
