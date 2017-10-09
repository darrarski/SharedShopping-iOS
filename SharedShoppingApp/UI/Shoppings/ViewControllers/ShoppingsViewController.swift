import UIKit

protocol ShoppingsViewControllerAssembly {
    var tableViewController: UIViewController { get }
}

protocol ShoppingsViewControllerInputs {
    var title: String { get }
}

protocol ShoppingsViewControllerOutputs {
    func addShopping()
}

class ShoppingsViewController: UIViewController {

    init(assembly: ShoppingsViewControllerAssembly,
         inputs: ShoppingsViewControllerInputs,
         outputs: ShoppingsViewControllerOutputs) {
        self.assembly = assembly
        self.inputs = inputs
        self.outputs = outputs
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View

    override func loadView() {
        view = UIView(frame: .zero)
        embed(assembly.tableViewController, in: view)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = inputs.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(rightBarButtonItemAction))
    }

    @objc func rightBarButtonItemAction() {
        outputs.addShopping()
    }

    // MARK: Private

    private let assembly: ShoppingsViewControllerAssembly
    private let inputs: ShoppingsViewControllerInputs
    private let outputs: ShoppingsViewControllerOutputs

}
