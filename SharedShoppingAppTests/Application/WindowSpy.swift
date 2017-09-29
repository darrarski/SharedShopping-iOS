import UIKit

class WindowSpy: UIWindow {

    var makeKeyAndVisibleCalled = false

    override func makeKeyAndVisible() {
        makeKeyAndVisibleCalled = true
    }

}
