import UIKit

protocol ShoppingsViewControllerAssembly {
    var tableViewController: UIViewController { get }
}

protocol ShoppingsViewControllerInputs {

}

class ShoppingsViewController: UIViewController {

    init(assembly: ShoppingsViewControllerAssembly, inputs: ShoppingsViewControllerInputs) {
        tableViewController = assembly.tableViewController
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View

    override func loadView() {
        view = UIView(frame: .zero)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        embed(tableViewController, in: view)
    }

    // MARK: Private

    private let tableViewController: UIViewController

}
