import UIKit
import RxSwift

class NavigationViewModel: NavigationViewControllerInputs {

    // MARK: NavigationViewControllerInputs

    var root: UIViewController {
        return UIViewController() // TODO:
    }

    var push: Observable<UIViewController> {
        return Observable.never() // TODO:
    }

}
