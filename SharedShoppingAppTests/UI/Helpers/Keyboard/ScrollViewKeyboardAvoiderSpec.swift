import Quick
import Nimble

@testable import SharedShoppingApp

class ScrollViewKeyboardAvoiderSpec: QuickSpec {

    override func spec() {
        describe("ScrollViewKeyboardAvoider") {
            var sut: ScrollViewKeyboardAvoider!
            var didAnimateWithDuration: TimeInterval?

            beforeEach {
                sut = ScrollViewKeyboardAvoider(animator: { (duration, animations) in
                    didAnimateWithDuration = duration
                    animations()
                })
            }

            describe("portrait screen") {
                var screenSize: CGSize!

                beforeEach {
                    screenSize = CGSize(width: 320, height: 240)
                }

                describe("full screen scroll view") {
                    var superview: UIView!
                    var scrollView: UIScrollView!

                    beforeEach {
                        superview = UIView(frame: CGRect(origin: .zero, size: screenSize))
                        scrollView = UIScrollView(frame: superview.bounds)
                        superview.addSubview(scrollView)
                    }

                    context("standard keyboard becomes partially visible") {
                        var change: KeyboardFrameChange!

                        beforeEach {
                            let size = CGSize(width: screenSize.width, height: 100)
                            let frame = CGRect(
                                origin: CGPoint(
                                    x: 0,
                                    y: screenSize.height - (size.height / 2)
                                ),
                                size: size
                            )
                            change = KeyboardFrameChange(frame: frame, animationDuration: 0.5)
                            sut.handleKeyboardFrameChange(change, for: scrollView)
                        }

                        it("should animate with correct duration") {
                            expect(didAnimateWithDuration).to(equal(change.animationDuration))
                        }

                        it("should set correct bottom content inset") {
                            expect(scrollView.contentInset.bottom).to(equal(change.frame.size.height / 2))
                        }

                        it("should set correct bottom indicator inset") {
                            expect(scrollView.scrollIndicatorInsets.bottom).to(equal(change.frame.size.height / 2))
                        }
                    }

                    context("standard keyboard becomes fully visible") {
                        var change: KeyboardFrameChange!

                        beforeEach {
                            let size = CGSize(width: screenSize.width, height: 100)
                            let frame = CGRect(
                                origin: CGPoint(
                                    x: 0,
                                    y: screenSize.height - size.height
                                ),
                                size: size
                            )
                            change = KeyboardFrameChange(frame: frame, animationDuration: 0.3)
                            sut.handleKeyboardFrameChange(change, for: scrollView)
                        }

                        it("should animate with correct duration") {
                            expect(didAnimateWithDuration).to(equal(change.animationDuration))
                        }

                        it("should set correct bottom content inset") {
                            expect(scrollView.contentInset.bottom).to(equal(change.frame.size.height))
                        }

                        it("should set correct bottom indicator inset") {
                            expect(scrollView.scrollIndicatorInsets.bottom).to(equal(change.frame.size.height))
                        }
                    }

                    context("standard keyboard becomes not visible") {
                        var change: KeyboardFrameChange!

                        beforeEach {
                            let size = CGSize(width: screenSize.width, height: 100)
                            let frame = CGRect(
                                origin: CGPoint(
                                    x: 0,
                                    y: screenSize.height
                                ),
                                size: size
                            )
                            change = KeyboardFrameChange(frame: frame, animationDuration: 0.7)
                            sut.handleKeyboardFrameChange(change, for: scrollView)
                        }

                        it("should animate with correct duration") {
                            expect(didAnimateWithDuration).to(equal(change.animationDuration))
                        }

                        it("should set correct bottom content inset") {
                            expect(scrollView.contentInset.bottom).to(equal(0))
                        }

                        it("should set correct bottom indicator inset") {
                            expect(scrollView.scrollIndicatorInsets.bottom).to(equal(0))
                        }
                    }
                }
            }
        }
    }

}
