import UIKit

class UIWindowSpy: UIWindow {

    var makeKeyAndVisibleCalled = false

    // MARK: UIWindow

    override func makeKeyAndVisible() {
        makeKeyAndVisibleCalled = true
    }

}
