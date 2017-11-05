import UIKit
@testable import SharedShoppingApp

class ScrollViewKeyboardAvoiderSpy: ScrollViewKeyboardAvoiding {

    var handledKeyboardChanges = [(KeyboardFrameChange, UIScrollView)]()

    // MARK: ScrollViewKeyboardAvoiding

    func handleKeyboardFrameChange(_ change: KeyboardFrameChange, for scrollView: UIScrollView) {
        handledKeyboardChanges.append((change, scrollView))
    }

}
