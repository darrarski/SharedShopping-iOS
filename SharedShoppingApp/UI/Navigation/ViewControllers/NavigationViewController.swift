import UIKit
import RxSwift

protocol NavigationViewControllerInputs {
    var root: UIViewController { get }
    var push: Observable<UIViewController> { get }
}

class NavigationViewController: UIViewController {

    init(navigationController: UINavigationController,
         inputs: NavigationViewControllerInputs) {
        self.childNavigationController = navigationController
        self.inputs = inputs
        super.init(nibName: nil, bundle: nil)
        self.childNavigationController.viewControllers = [inputs.root]
        setupBindings()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View

    override func viewDidLoad() {
        super.viewDidLoad()
        embed(childNavigationController, in: view)
    }

    // MARK: Private

    private var inputs: NavigationViewControllerInputs
    private let childNavigationController: UINavigationController
    private let disposeBag = DisposeBag()

    private func setupBindings() {
        inputs.push
            .subscribe(onNext: { [weak self] in
                self?.childNavigationController.pushViewController($0, animated: true)
            })
            .disposed(by: disposeBag)
    }

}
