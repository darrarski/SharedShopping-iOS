import UIKit

protocol CreateShoppingViewControllerOutputs {
    func createShopping()
}

class CreateShoppingViewController: UIViewController {

    init(outputs: CreateShoppingViewControllerOutputs) {
        self.outputs = outputs
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View

    override func loadView() {
        view = UIView(frame: .zero)
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(rightBarButtonItemAction))
    }

    @objc func rightBarButtonItemAction() {
        outputs.createShopping()
    }

    // MARK: Private

    private let outputs: CreateShoppingViewControllerOutputs

}
