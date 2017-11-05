import RxSwift
@testable import SharedShoppingApp

class KeyboardFrameChangeListenerMock: KeyboardFrameChangeListening {

    func simulateKeyboardFrameChange(_ change: KeyboardFrameChange) {
        keyboardWillChangeFrameSubject.onNext(change)
    }

    // MARK: KeyboardFrameChangeListening

    var keyboardWillChangeFrame: Observable<KeyboardFrameChange> {
        return keyboardWillChangeFrameSubject.asObservable()
    }

    // MARK: Private

    private let keyboardWillChangeFrameSubject = PublishSubject<KeyboardFrameChange>()

}
