import UIKit
import ScrollViewController
import RxSwift

protocol CreateShoppingViewControllerInputs {
    var startEditing: Observable<Void> { get }
}

protocol CreateShoppingViewControllerOutputs {
    func viewDidAppear()
    func createShopping()
}

class CreateShoppingViewController: UIViewController {

    init(scrollViewController: ScrollViewController,
         inputs: CreateShoppingViewControllerInputs,
         outputs: CreateShoppingViewControllerOutputs) {
        self.scrollViewController = scrollViewController
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
        view.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha: 1)
        embed(scrollViewController, in: view)
        scrollViewController.scrollView.alwaysBounceVertical = true
        scrollViewController.contentView = CreateShoppingView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(rightBarButtonItemAction))
        bind(inputs)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        outputs.viewDidAppear()
    }

    @objc func rightBarButtonItemAction() {
        outputs.createShopping()
    }

    private var createShoppingView: CreateShoppingView! {
        _ = view
        return scrollViewController.contentView as? CreateShoppingView
    }

    // MARK: Private

    private let scrollViewController: ScrollViewController
    private let inputs: CreateShoppingViewControllerInputs
    private let outputs: CreateShoppingViewControllerOutputs
    private let disposeBag = DisposeBag()

    private func bind(_ inputs: CreateShoppingViewControllerInputs) {
        inputs.startEditing
            .subscribe(onNext: { [weak self] in self?.createShoppingView.textView.becomeFirstResponder() })
            .disposed(by: disposeBag)
    }

}
