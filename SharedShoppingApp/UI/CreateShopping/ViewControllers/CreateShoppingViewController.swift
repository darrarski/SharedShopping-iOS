import UIKit
import ScrollViewController
import RxSwift

protocol CreateShoppingViewControllerInputs {
    var title: Observable<String?> { get }
    var startEditing: Observable<Void> { get }
    var shoppingName: Observable<String?> { get }
    var selectShoppingNameText: Observable<Void> { get }
    var createButtonTitle: Observable<String?> { get }
    var createButtonEnabled: Observable<Bool> { get }
}

protocol CreateShoppingViewControllerOutputs {
    func viewDidAppear()
    func shoppingNameDidChange(_ name: String?)
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        bind(inputs)
        bind(outputs)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        outputs.viewDidAppear()
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
        inputs.title
            .subscribe(onNext: { [weak self] in self?.navigationItem.title = $0 })
            .disposed(by: disposeBag)

        inputs.startEditing
            .subscribe(onNext: { [weak self] in self?.createShoppingView.textView.becomeFirstResponder() })
            .disposed(by: disposeBag)

        inputs.shoppingName
            .distinctUntilChanged { $0 == $1 }
            .bind(to: createShoppingView.textView.rx.text)
            .disposed(by: disposeBag)

        inputs.selectShoppingNameText
            .subscribe(onNext: { [weak self] in self?.createShoppingView.textView.selectAll(nil) })
            .disposed(by: disposeBag)

        inputs.createButtonTitle
            .subscribe(onNext: { [weak self] in self?.navigationItem.rightBarButtonItem?.title = $0 })
            .disposed(by: disposeBag)

        inputs.createButtonEnabled
            .subscribe(onNext: { [weak self] in self?.navigationItem.rightBarButtonItem?.isEnabled = $0 })
            .disposed(by: disposeBag)
    }

    private func bind(_ inputs: CreateShoppingViewControllerOutputs) {
        createShoppingView.textView.rx.text
            .skip(1)
            .distinctUntilChanged { $0 == $1 }
            .subscribe(onNext: { [weak self] in self?.outputs.shoppingNameDidChange($0) })
            .disposed(by: disposeBag)

        navigationItem.rightBarButtonItem?.rx.tap
            .subscribe(onNext: { [weak self] in self?.outputs.createShopping() })
            .disposed(by: disposeBag)
    }

}
