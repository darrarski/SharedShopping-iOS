import Quick
import Nimble
import ScrollViewController
import RxSwift

@testable import SharedShoppingApp

class CreateShoppingViewControllerSpec: QuickSpec {

    override func spec() {
        describe("CreateShoppingViewController") {
            var sut: CreateShoppingViewController!

            context("init with coder") {
                beforeEach {
                    sut = CreateShoppingViewController(coder: NSCoder())
                }

                it("should be nil") {
                    expect(sut).to(beNil())
                }
            }

            context("init") {
                var scrollViewController: ScrollViewController!
                var inputs: Inputs!
                var outputs: Outputs!

                beforeEach {
                    scrollViewController = ScrollViewController()
                    inputs = Inputs()
                    outputs = Outputs()
                    sut = CreateShoppingViewController(
                        scrollViewController: scrollViewController,
                        inputs: inputs,
                        outputs: outputs
                    )
                }

                context("load view") {
                    var createShoppingView: CreateShoppingView!

                    beforeEach {
                        _ = sut.view
                        createShoppingView = scrollViewController.contentView as? CreateShoppingView
                    }

                    describe("right bar button item in navigation item") {
                        var button: UIBarButtonItem?

                        beforeEach {
                            button = sut.navigationItem.rightBarButtonItem
                        }

                        it("should not be nil") {
                            expect(button).notTo(beNil())
                        }

                        context("tap") {
                            beforeEach {
                                _ = button?.target?.perform(button?.action)
                            }

                            it("should create shopping") {
                                expect(outputs.didCreateShopping).to(beTrue())
                            }
                        }
                    }

                    it("should embed scroll view controller") {
                        expect(sut.childViewControllers).to(contain(scrollViewController))
                    }

                    it("should enable bouncing in scroll view controller") {
                        expect(scrollViewController.scrollView.alwaysBounceVertical).to(beTrue())
                    }

                    it("should set correct view for scroll view controller content") {
                        expect(scrollViewController.contentView).to(beAKindOf(CreateShoppingView.self))
                    }

                    it("should set correct content view") {
                        expect(createShoppingView).notTo(beNil())
                    }

                    context("when view did appear") {
                        beforeEach {
                            sut.viewDidAppear(false)
                        }

                        it("should call outputs.viewDidAppear") {
                            expect(outputs.viewDidAppearCalled).to(beTrue())
                        }
                    }

                    context("start editing") {
                        var observer: MethodCallObserver!
                        var selector: Selector!

                        beforeEach {
                            observer = MethodCallObserver()
                            selector = #selector(UITextView.becomeFirstResponder)
                            observer.observe(createShoppingView.textView, selector)
                            inputs.simulateStartEditing()
                        }

                        it("should make text view first responder") {
                            expect(observer.observedCalls.last?.selector).to(equal(selector))
                        }
                    }
                }
            }
        }
    }

    private class Inputs: CreateShoppingViewControllerInputs {

        func simulateStartEditing() {
            startEditingSubject.onNext(())
        }

        // MARK: CreateShoppingViewControllerInputs

        var startEditing: Observable<Void> {
            return startEditingSubject.asObservable()
        }

        // MARK: Private

        private let startEditingSubject = PublishSubject<Void>()

    }

    private class Outputs: CreateShoppingViewControllerOutputs {

        var viewDidAppearCalled = false
        var didCreateShopping = false

        // MARK: CreateShoppingViewControllerOutputs

        func viewDidAppear() {
            viewDidAppearCalled = true
        }

        func createShopping() {
            didCreateShopping = true
        }

    }

}
