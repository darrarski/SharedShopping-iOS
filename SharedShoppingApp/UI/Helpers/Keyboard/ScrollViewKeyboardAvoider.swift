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
        if intersectionExists(frame: scrollView.bounds, keyboardFrame: keyboardFrame) {
            insets.bottom = scrollView.bounds.maxY - keyboardFrame.minY
        }
        animate(change.animationDuration) {
            scrollView.contentInset = insets
            scrollView.scrollIndicatorInsets = insets
        }
    }

    // MARK: Private

    private let animate: Animator

    private func intersectionExists(frame: CGRect, keyboardFrame: CGRect) -> Bool {
        return keyboardFrame.intersects(frame) &&
            !keyboardFrame.contains(frame) &&
            keyboardFrame.size.height != frame.size.height &&
            !keyboardFrame.size.equalTo(.zero)
    }

}
