import UIKit
import RxSwift

protocol ShoppingsViewControllerInputs {
    var title: Observable<String?> { get }
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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        bind(inputs)
        bind(outputs)
    }

    // MARK: Private

    private let tableViewControllerFactory: () -> UIViewController
    private let inputs: ShoppingsViewControllerInputs
    private let outputs: ShoppingsViewControllerOutputs
    private let disposeBag = DisposeBag()

    private func bind(_ inputs: ShoppingsViewControllerInputs) {
        inputs.title
            .subscribe(onNext: { [weak self] in self?.navigationItem.title = $0 })
            .disposed(by: disposeBag)
    }

    private func bind(_ outputs: ShoppingsViewControllerOutputs) {
        navigationItem.rightBarButtonItem?.rx.tap
            .subscribe(onNext: { [weak self] in self?.outputs.addShopping() })
            .disposed(by: disposeBag)
    }

}
