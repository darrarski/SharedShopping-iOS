import UIKit

protocol CreateShoppingViewControllerOutputs {
    func createShopping()
}

class CreateShoppingViewController: UIViewController {

    init(scrollViewController: ScrollViewController,
         outputs: CreateShoppingViewControllerOutputs) {
        self.scrollViewController = scrollViewController
        self.outputs = outputs
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    // MARK: View

    override func loadView() {
        view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha: 1)
        embed(scrollViewController, in: view)
        scrollViewController.contentView = CreateShoppingView()
        scrollViewController.scrollView.alwaysBounceVertical = true
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

    private let scrollViewController: ScrollViewController
    private let outputs: CreateShoppingViewControllerOutputs

}
