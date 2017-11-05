import UIKit

class ScrollViewKeyboardAvoider: ScrollViewKeyboardAvoiding {

    typealias Animator = (TimeInterval, @escaping () -> Void) -> Void

    init(animator: @escaping Animator) {
        self.animate = animator
    }

    // MARK: ScrollViewKeyboardAvoiding

    func handleKeyboardFrameChange(_ change: KeyboardFrameChange, for scrollView: UIScrollView) {
        let keyboardFrame = scrollView.convert(change.frame, from: nil)
        var insets = UIEdgeInsets.zero
        if keyboardFrame.minY < scrollView.frame.maxY && keyboardFrame.maxY >= scrollView.frame.maxY {
            insets.bottom = scrollView.frame.maxY - keyboardFrame.minY
        }
        animate(change.animationDuration) {
            scrollView.contentInset = insets
            scrollView.scrollIndicatorInsets = insets
        }
    }

    // MARK: Private

    private let animate: Animator

}
