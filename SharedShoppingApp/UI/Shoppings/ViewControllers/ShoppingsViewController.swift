import UIKit

protocol ShoppingsViewControllerAssembly {
    var tableViewController: UIViewController { get }
}

protocol ShoppingsViewControllerInputs {
    var title: String { get }
}

protocol ShoppingsViewControllerOutputs {

}

class ShoppingsViewController: UIViewController {

    init(assembly: ShoppingsViewControllerAssembly,
         inputs: ShoppingsViewControllerInputs,
         outputs: ShoppingsViewControllerOutputs) {
        tableViewController = assembly.tableViewController
        super.init(nibName: nil, bundle: nil)
        title = inputs.title
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(rightBarButtonItemAction))
        embed(tableViewController, in: view)
    }

    @objc func rightBarButtonItemAction() {
        // TODO:
    }

    // MARK: Private

    private let tableViewController: UIViewController

}
