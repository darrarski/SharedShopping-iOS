import RxSwift

class KeyboardFrameChangeListener: KeyboardFrameChangeListening {

    init(notificationCenter: NotificationCenter) {
        self.notificationCenter = notificationCenter
        observe()
    }

    // MARK: KeyboardFrameChangeListening

    var keyboardWillChangeFrame: Observable<KeyboardFrameChange> {
        return keyboardWillChangeFrameSubject.asObservable()
    }

    // MARK: Private

    private let notificationCenter: NotificationCenter
    private let keyboardWillChangeFrameSubject = PublishSubject<KeyboardFrameChange>()
    private var token: NSObjectProtocol?

    private func observe() {
        token = notificationCenter.addObserver(
            forName: Notification.Name.UIKeyboardWillChangeFrame,
            object: nil,
            queue: nil,
            using: { [weak self] in self?.handle($0) }
        )
    }

    private func handle(_ notification: Notification) {
        guard let endFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect,
              let animationDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double else {
            return
        }
        let change = KeyboardFrameChange(frame: endFrame, animationDuration: animationDuration)
        keyboardWillChangeFrameSubject.onNext(change)
    }

}
