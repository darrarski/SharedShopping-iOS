import Quick
import Nimble
import RxTest

@testable import SharedShoppingApp

class KeyboardFrameChangeListenerSpec: QuickSpec {

    override func spec() {
        describe("KeyboardFrameChangeListener") {
            var sut: KeyboardFrameChangeListener!
            var notificationCenter: NotificationCenter!
            var scheduler: TestScheduler!
            var keyboardWillChangeFrameObserver: TestableObserver<KeyboardFrameChange>!

            beforeEach {
                notificationCenter = NotificationCenter()
                sut = KeyboardFrameChangeListener(notificationCenter: notificationCenter)
                scheduler = TestScheduler(initialClock: 0)
                keyboardWillChangeFrameObserver = scheduler.createObserver(KeyboardFrameChange.self)
                _ = sut.keyboardWillChangeFrame.subscribe(keyboardWillChangeFrameObserver)
            }

            context("keyboard will change frame notification") {
                var frame: CGRect!
                var animationDuration: TimeInterval!

                beforeEach {
                    frame = CGRect(x: 5, y: 7, width: 19, height: 21)
                    animationDuration = 0.12
                    notificationCenter.post(Notification(
                        name: Notification.Name.UIKeyboardWillChangeFrame,
                        object: nil,
                        userInfo: [
                            UIKeyboardFrameEndUserInfoKey: frame,
                            UIKeyboardAnimationDurationUserInfoKey: animationDuration
                        ]
                    ))
                }

                it("should emit one change") {
                    expect(keyboardWillChangeFrameObserver.events).to(haveCount(1))
                }

                describe("last emited change") {
                    var change: KeyboardFrameChange?

                    beforeEach {
                        change = keyboardWillChangeFrameObserver.events.last?.value.element
                    }

                    it("should not be nil") {
                        expect(change).notTo(beNil())
                    }

                    it("should have correct frame") {
                        expect(change?.frame).to(equal(frame))
                    }

                    it("should have correct animation duration") {
                        expect(change?.animationDuration).to(equal(animationDuration))
                    }
                }
            }

            context("invalid notification") {
                beforeEach {
                    notificationCenter.post(Notification(
                        name: Notification.Name.UIKeyboardWillChangeFrame,
                        object: nil,
                        userInfo: [:]
                    ))
                }

                it("should not emit changes") {
                    expect(keyboardWillChangeFrameObserver.events).to(beEmpty())
                }
            }
        }
    }

}
