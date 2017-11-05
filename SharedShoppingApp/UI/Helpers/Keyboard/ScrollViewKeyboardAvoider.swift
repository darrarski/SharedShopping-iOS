import UIKit
import RxSwift

class ScrollViewKeyboardAvoider: ScrollViewKeyboardAvoiding {

    typealias Animator = (TimeInterval, @escaping () -> Void) -> Void

    init(animator: @escaping Animator) {
        self.animate = animator
    }

    // MARK: ScrollViewKeyboardAvoiding

    func observeKeyboardFrameChanges(for scrollView: UIScrollView) -> AnyObserver<KeyboardFrameChange> {
        return AnyObserver(eventHandler: { [weak self, weak scrollView] event in
            switch event {
            case .completed, .error:
                return
            case .next(let change):
                guard let scrollView = scrollView else { return }
                self?.handleKeyboardFrameChange(change, for: scrollView)
            }
        })
    }

    // MARK: Private

    private let animate: Animator

    private func handleKeyboardFrameChange(_ change: KeyboardFrameChange, for scrollView: UIScrollView) {
        guard let superview = scrollView.superview else { return }
        let keyboardFrame = superview.convert(change.frame, from: nil)
        var insets = UIEdgeInsets.zero
        let bottomCoverage = scrollView.frame.maxY - keyboardFrame.minY
        if bottomCoverage > 0 {
            insets.bottom = max(bottomCoverage - scrollView.safeAreaInsets.bottom, scrollView.safeAreaInsets.bottom)
        }
        animate(change.animationDuration) {
            scrollView.contentInset = insets
            scrollView.scrollIndicatorInsets = insets
            scrollView.layoutIfNeeded()
        }
    }

}
