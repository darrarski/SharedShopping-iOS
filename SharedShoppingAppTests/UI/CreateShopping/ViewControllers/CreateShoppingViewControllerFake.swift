import UIKit
@testable import SharedShoppingApp
import ScrollViewController
import RxSwift

class CreateShoppingViewControllerFake: CreateShoppingViewController {

    init() {
        super.init(scrollViewController: ScrollViewController(),
                   inputs: InputsFake(),
                   outputs: OutputsFake())
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

private struct InputsFake: CreateShoppingViewControllerInputs {

    var startEditing: Observable<Void> {
        return Observable.never()
    }

}

private struct OutputsFake: CreateShoppingViewControllerOutputs {

    func viewDidAppear() {}

    func createShopping() {}

}