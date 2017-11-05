import Quick
import Nimble

@testable import SharedShoppingApp

class ScrollViewControllerSpec: QuickSpec {

    override func spec() {
        describe("ScrollViewController") {
            var sut: ScrollViewController!
            var keyboardFrameChangeListenerMock: KeyboardFrameChangeListenerMock!
            var scrollViewKeyboardAvoiderSpy: ScrollViewKeyboardAvoiderSpy!

            beforeEach {
                keyboardFrameChangeListenerMock = KeyboardFrameChangeListenerMock()
                scrollViewKeyboardAvoiderSpy = ScrollViewKeyboardAvoiderSpy()
                sut = ScrollViewController(
                    keyboardListener: keyboardFrameChangeListenerMock,
                    scrollViewKeyboardAvoider: scrollViewKeyboardAvoiderSpy
                )
            }

            context("load view") {
                beforeEach {
                    _ = sut.view
                }

                context("keyboard frame changes") {
                    var change: KeyboardFrameChange!

                    beforeEach {
                        change = KeyboardFrameChange(
                            frame: CGRect(x: 4, y: 12, width: 36, height: 108),
                            animationDuration: 0.1
                        )
                        keyboardFrameChangeListenerMock.simulateKeyboardFrameChange(change)
                    }

                    it("should handle single change") {
                        expect(scrollViewKeyboardAvoiderSpy.handledKeyboardChanges).to(haveCount(1))
                    }

                    it("should avoid keyboard in correct scroll view") {
                        expect(scrollViewKeyboardAvoiderSpy.handledKeyboardChanges.first?.1)
                            .to(be((sut.view as! ScrollWrapperView).scrollView))
                    }

                    it("should avoid keyboard using correct change") {
                        expect(scrollViewKeyboardAvoiderSpy.handledKeyboardChanges.first?.0.frame)
                            .to(equal(change.frame))
                        expect(scrollViewKeyboardAvoiderSpy.handledKeyboardChanges.first?.0.animationDuration)
                            .to(equal(change.animationDuration))
                    }
                }

                context("set content view") {
                    var view: UIView!

                    beforeEach {
                        view = UIView(frame: .zero)
                        sut.contentView = view
                    }

                    it("should content view be embedded in scroll view") {
                        expect(view).to(beAChildOf((sut.view as! ScrollWrapperView).scrollView))
                    }

                    it("should have correct content view") {
                        expect(sut.contentView).to(be(view))
                    }

                    context("set content view to nil") {
                        beforeEach {
                            sut.contentView = nil
                        }

                        it("should remove previously set content view") {
                            expect(view.superview).to(beNil())
                        }

                        it("should have nil content view") {
                            expect(sut.contentView).to(beNil())
                        }
                    }
                }
            }
        }
    }

}

private func beAChildOf(_ parent: UIView) -> Predicate<UIView> {
    return Predicate {
        let msg = "be a child of \(parent)"
        guard let actual = try $0.evaluate() else {
            return PredicateResult(
                bool: false,
                message: ExpectationMessage.appends(.expectedTo(msg), ", got nil").appendedBeNilHint()
            )
        }
        var superview = actual.superview
        while superview != nil {
            if superview == parent {
                return PredicateResult(bool: true, message: .expectedTo(msg))
            }
            superview = superview?.superview
        }
        return PredicateResult(bool: false, message: .expectedTo(msg))
    }
}
