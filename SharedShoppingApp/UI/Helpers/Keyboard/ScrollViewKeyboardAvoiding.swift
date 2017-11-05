import UIKit

protocol ScrollViewKeyboardAvoiding {
    func handleKeyboardFrameChange(_ change: KeyboardFrameChange, for scrollView: UIScrollView)
}
