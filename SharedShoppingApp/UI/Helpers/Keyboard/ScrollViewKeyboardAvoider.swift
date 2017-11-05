import UIKit

class ScrollViewKeyboardAvoider: ScrollViewKeyboardAvoiding {

    typealias Animator = (TimeInterval, @escaping () -> Void) -> Void

    init(animator: @escaping Animator) {
        self.animate = animator
    }

    // MARK: ScrollViewKeyboardAvoiding

    func handleKeyboardFrameChange(_ change: KeyboardFrameChange, for scrollView: UIScrollView) {
        guard let superview = scrollView.superview else { return }
        let keyboardFrame = superview.convert(change.frame, from: nil)
        var insets = UIEdgeInsets.zero
        let bottomCoverage = scrollView.frame.maxY - keyboardFrame.minY
        if bottomCoverage > 0 {
            insets.bottom = bottomCoverage
        }
        animate(change.animationDuration) {
            scrollView.contentInset = insets
            scrollView.scrollIndicatorInsets = insets
        }
    }

    // MARK: Private

    private let animate: Animator

}
