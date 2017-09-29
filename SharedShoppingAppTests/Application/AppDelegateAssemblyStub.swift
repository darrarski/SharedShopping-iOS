import UIKit
@testable import SharedShoppingApp

class AppDelegateAssemblyStub: NSObject, AppDelegateAssembly {

    let windowSpy = WindowSpy()

    // MARK: AppDelegateAssembly

    var window: UIWindow {
        return windowSpy
    }

}
