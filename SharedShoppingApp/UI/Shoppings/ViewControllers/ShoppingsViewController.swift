import UIKit

protocol ShoppingsViewControllerInputs {
    var title: String { get }
}

protocol ShoppingsViewControllerOutputs {
    func addShopping()
}

class ShoppingsViewController: UIViewController {

    init(tableViewControllerFactory: @escaping () -> UIViewController,
         inputs: ShoppingsViewControllerInputs,
         outputs: ShoppingsViewControllerOutputs) {
        self.tableViewControllerFactory = tableViewControllerFactory
        self.inputs = inputs
        self.outputs = outputs
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: View

    override func loadView() {
        view = UIView(frame: .zero)
        embed(tableViewControllerFactory(), in: view)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = inputs.title
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(rightBarButtonItemAction))
    }

    @objc func rightBarButtonItemAction() {
        outputs.addShopping()
    }

    // MARK: Private

    private let tableViewControllerFactory: () -> UIViewController
    private let inputs: ShoppingsViewControllerInputs
    private let outputs: ShoppingsViewControllerOutputs

}
