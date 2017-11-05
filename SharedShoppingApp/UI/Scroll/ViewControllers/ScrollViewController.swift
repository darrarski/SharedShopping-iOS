import UIKit
import RxSwift

class ScrollViewController: UIViewController {

    init(keyboardListener: KeyboardFrameChangeListening,
         scrollViewKeyboardAvoider: ScrollViewKeyboardAvoiding) {
        self.keyboardListener = keyboardListener
        self.scrollViewKeyboardAvoider = scrollViewKeyboardAvoider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View

    var contentView: UIView? {
        get { return scrollView.contentView }
        set { scrollView.contentView = newValue }
    }

    override func loadView() {
        view = ScrollView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    private var scrollView: ScrollView! {
        return self.view as? ScrollView
    }

    // MARK: Private

    private let keyboardListener: KeyboardFrameChangeListening
    private let scrollViewKeyboardAvoider: ScrollViewKeyboardAvoiding
    private let disposeBag = DisposeBag()

    private func setupBindings() {
        keyboardListener.keyboardWillChangeFrame
            .bind(to: scrollViewKeyboardAvoider.observeKeyboardFrameChanges(for: scrollView.scrollView))
            .disposed(by: disposeBag)
    }

}
