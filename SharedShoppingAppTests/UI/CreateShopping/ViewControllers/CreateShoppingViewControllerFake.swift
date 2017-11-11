import UIKit
import ScrollViewController
@testable import SharedShoppingApp

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

}

private struct OutputsFake: CreateShoppingViewControllerOutputs {

    func viewDidAppear() {}

    func createShopping() {}

}
