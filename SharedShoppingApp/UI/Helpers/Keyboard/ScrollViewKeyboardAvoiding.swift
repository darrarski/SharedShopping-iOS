import UIKit
import RxSwift

protocol ScrollViewKeyboardAvoiding {
    func observeKeyboardFrameChanges(for scrollView: UIScrollView) -> AnyObserver<KeyboardFrameChange>
}
