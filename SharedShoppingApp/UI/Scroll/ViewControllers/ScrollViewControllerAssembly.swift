import Swinject
import SwinjectAutoregistration

class ScrollViewControllerAssembly: Assembly {

    func assemble(container: Container) {
        container.register(ScrollViewController.self) { _ in
            ScrollViewController(
                keyboardListener: KeyboardFrameChangeListener(
                    notificationCenter: NotificationCenter.default
                ),
                scrollViewKeyboardAvoider: ScrollViewKeyboardAvoider {
                    (duration, animations) in UIView.animate(withDuration: duration, animations: animations)
                }
            )
        }
    }

}
