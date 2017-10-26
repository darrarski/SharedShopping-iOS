import UIKit

protocol AppWindowCreating {
    func createAppWindow() -> UIWindow
}

class AppWindowFactory: AppWindowCreating {

    init(size: CGSize) {
        self.size = size
    }

    // MARK: AppWindowCreating

    func createAppWindow() -> UIWindow {
        return UIWindow(frame: CGRect(origin: .zero, size: size))
    }

    // MARK: Private

    private let size: CGSize

}
