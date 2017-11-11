import Quick
import Nimble
import ScrollViewController

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
                    beforeEach {
                        _ = sut.view
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

                    context("when view did appear") {
                        beforeEach {
                            sut.viewDidAppear(false)
                        }

                        it("should call outputs.viewDidAppear") {
                            expect(outputs.viewDidAppearCalled).to(beTrue())
                        }
                    }
                }
            }
        }
    }

    private class Inputs: CreateShoppingViewControllerInputs {

        // MARK: CreateShoppingViewControllerInputs

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
