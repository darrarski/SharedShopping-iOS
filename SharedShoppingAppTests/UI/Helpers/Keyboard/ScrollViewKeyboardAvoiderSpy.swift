import UIKit
import RxSwift
@testable import SharedShoppingApp

class ScrollViewKeyboardAvoiderSpy: ScrollViewKeyboardAvoiding {

    var handledKeyboardChanges = [(UIScrollView, KeyboardFrameChange)]()

    // MARK: ScrollViewKeyboardAvoiding

    func observeKeyboardFrameChanges(for scrollView: UIScrollView) -> AnyObserver<KeyboardFrameChange> {
        return AnyObserver(eventHandler: { event in
            switch event {
            case .error, .completed:
                return
            case .next(let change):
                self.handledKeyboardChanges.append((scrollView, change))
            }
        })
    }

}
