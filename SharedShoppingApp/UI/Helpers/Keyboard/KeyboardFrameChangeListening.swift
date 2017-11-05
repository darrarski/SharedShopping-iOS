import RxSwift

protocol KeyboardFrameChangeListening {
    var keyboardWillChangeFrame: Observable<KeyboardFrameChange> { get }
}
