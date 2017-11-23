import Quick
import Nimble
import ScrollViewController
import RxSwift
import EarlGrey

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

                context("present on screen") {
                    var createShoppingView: CreateShoppingView!

                    beforeEach {
                        EarlGrey.presentViewController(UINavigationController(rootViewController: sut))
                        createShoppingView = scrollViewController.contentView as? CreateShoppingView
                    }

                    afterEach {
                        EarlGrey.cleanUpAfterPresentingViewController()
                    }

                    it("should have correct title") {
                        expect(sut.navigationItem.title).to(equal(try! inputs.title.toBlocking().first()!))
                    }

                    it("should right navigation item button have correct title") {
                        expect(sut.navigationItem.rightBarButtonItem?.title)
                            .to(equal(try! inputs.createButtonTitle.toBlocking().first()!))
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

                    context("enable create button") {
                        beforeEach {
                            inputs.createButtonEnabledVar.value = true
                        }

                        it("should be enabled") {
                            expect(sut.navigationItem.rightBarButtonItem?.isEnabled).to(beTrue())
                        }

                        context("tap create button") {
                            beforeEach {
                                EarlGrey.select(elementWithMatcher: grey_accessibilityElement(sut.navigationItem.rightBarButtonItem!))
                                    .perform(grey_tap())
                            }

                            it("should trigger action") {
                                expect(outputs.didCreateShopping).to(beTrue())
                            }
                        }
                    }

                    context("disable create button") {
                        beforeEach {
                            inputs.createButtonEnabledVar.value = false
                        }

                        it("should be enabled") {
                            expect(sut.navigationItem.rightBarButtonItem?.isEnabled).to(beFalse())
                        }
                    }

                    context("view did appear") {
                        beforeEach {
                            sut.viewDidAppear(false)
                        }

                        it("should call outputs.viewDidAppear") {
                            expect(outputs.viewDidAppearCalled).to(beTrue())
                        }
                    }

                    context("start editing") {
                        beforeEach {
                            inputs.simulateStartEditing()
                        }

                        it("should make text view first responder") {
                            expect(createShoppingView.textView.isFirstResponder).to(beTrue())
                        }
                    }

                    context("change shopping name") {
                        var name: String!

                        beforeEach {
                            name = "New Shopping Name"
                            inputs.shoppingNameVar.value = name
                        }

                        it("should update text view") {
                            expect(createShoppingView.textView.text).to(equal(name))
                        }
                    }

                    context("select shopping name text") {
                        beforeEach {
                            createShoppingView.textView.text = "TEST"
                            inputs.simulateSelectShoppingNameText()
                        }

                        it("should select text") {
                            let expectation = NSRange(location: 0, length: createShoppingView.textView.text!.count)
                            expect(createShoppingView.textView.selectedRange).to(equal(expectation))
                        }
                    }

                    context("when entering shopping name") {
                        var name: String!

                        beforeEach {
                            name = "Test Shopping Name"
                            EarlGrey.select(elementWithMatcher: grey_kindOfClass(UITextView.self))
                                .perform(grey_replaceText(name))
                        }

                        it("should pass name changes to output") {
                            expect(outputs.shoppingNameChanges).to(equal([name]))
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

        let shoppingNameVar = Variable<String?>(nil)

        func simulateSelectShoppingNameText() {
            selectShoppingNameTextSubject.onNext(())
        }

        let createButtonEnabledVar = Variable<Bool>(false)

        // MARK: CreateShoppingViewControllerInputs

        var title: Observable<String?> {
            return Observable.just("Test Title")
        }

        var startEditing: Observable<Void> {
            return startEditingSubject.asObservable()
        }

        var shoppingName: Observable<String?> {
            return shoppingNameVar.asObservable()
        }

        var selectShoppingNameText: Observable<Void> {
            return selectShoppingNameTextSubject.asObservable()
        }

        var createButtonTitle: Observable<String?> {
            return Observable.just("Create Button Title")
        }

        var createButtonEnabled: Observable<Bool> {
            return createButtonEnabledVar.asObservable()
        }

        // MARK: Private

        private let startEditingSubject = PublishSubject<Void>()
        private let selectShoppingNameTextSubject = PublishSubject<Void>()

    }

    private class Outputs: CreateShoppingViewControllerOutputs {

        var viewDidAppearCalled = false
        var shoppingNameChanges = [String?]()
        var didCreateShopping = false

        // MARK: CreateShoppingViewControllerOutputs

        func viewDidAppear() {
            viewDidAppearCalled = true
        }

        func shoppingNameDidChange(_ name: String?) {
            shoppingNameChanges.append(name)
        }

        func createShopping() {
            didCreateShopping = true
        }

    }

}
