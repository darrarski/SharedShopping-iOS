import UIKit

extension Container {

    var appWindowFactory: AppWindowFactory {
        return AppWindowFactory(size: UIScreen.main.bounds.size)
    }

}
