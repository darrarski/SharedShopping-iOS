import UIKit
import RxSwift

class ScrollViewController: UIViewController, UIScrollViewDelegate {

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

    var scrollView: UIScrollView {
        return scrollWrapperView.scrollView
    }

    var contentView: UIView? {
        get { return scrollWrapperView.contentView }
        set { scrollWrapperView.contentView = newValue }
    }

    private var scrollWrapperView: ScrollWrapperView! {
        return self.view as? ScrollWrapperView
    }

    override func loadView() {
        view = ScrollWrapperView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollWrapperView.scrollView.delegate = self
        setupBindings()
    }

    // MARK: UIScrollViewDelegate

    func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        self.scrollWrapperView.updateVisibleContentLayoutGuide(insets: scrollView.adjustedContentInset)
    }

    // MARK: Private

    private let keyboardListener: KeyboardFrameChangeListening
    private let scrollViewKeyboardAvoider: ScrollViewKeyboardAvoiding
    private let disposeBag = DisposeBag()

    private func setupBindings() {
        keyboardListener.keyboardWillChangeFrame
            .subscribe(onNext: { [weak self] change in
                guard let scrollView = self?.scrollView else { return }
                self?.scrollViewKeyboardAvoider.handleKeyboardFrameChange(change, for: scrollView)
            })
            .disposed(by: disposeBag)
    }

}
