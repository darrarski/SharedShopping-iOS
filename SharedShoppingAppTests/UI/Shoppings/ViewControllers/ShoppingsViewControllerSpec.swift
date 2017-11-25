import Quick
import Nimble
import EarlGrey
import RxSwift
import RxBlocking
@testable import SharedShoppingApp

class ShoppingsViewControllerSpec: QuickSpec {

    override func spec() {
        describe("ShoppingsViewController") {
            var sut: ShoppingsViewController!

            context("init with coder") {
                beforeEach {
                    sut = ShoppingsViewController(coder: NSCoder())
                }

                it("should be nil") {
                    expect(sut).to(beNil())
                }
            }

            context("init") {
                var tableViewController: UIViewController!
                var inputs: Inputs!
                var outputs: Outputs!

                it("should not init with coder") {
                    expect(ShoppingViewController(coder: NSCoder())).to(beNil())
                }

                beforeEach {
                    tableViewController = UIViewController(nibName: nil, bundle: nil)
                    inputs = Inputs()
                    outputs = Outputs()
                    sut = ShoppingsViewController(
                        tableViewControllerFactory: { tableViewController },
                        inputs: inputs,
                        outputs: outputs
                    )
                }

                context("present on screen") {
                    beforeEach {
                        EarlGrey.presentViewController(UINavigationController(rootViewController: sut))
                    }

                    afterEach {
                        EarlGrey.cleanUpAfterPresentingViewController()
                    }

                    it("should embed tableViewController") {
                        expect(sut.childViewControllers).to(contain(tableViewController))
                    }

                    it("should have correct title") {
                        expect(sut.navigationItem.title).to(equal(try! inputs.title.toBlocking().first()!))
                    }

                    describe("back bar button item") {
                        var button: UIBarButtonItem?

                        beforeEach {
                            button = sut.navigationItem.backBarButtonItem
                        }

                        it("should not be nil") {
                            expect(button).notTo(beNil())
                        }

                        it("should have empty title") {
                            expect(button?.title).to(equal(""))
                        }
                    }

                    describe("right bar button item") {
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

                            it("should call addShopping") {
                                expect(outputs.addShoppingCalled).to(beTrue())
                            }
                        }
                    }
                }
            }
        }
    }

    private class Inputs: ShoppingsViewControllerInputs {

        var title: Observable<String?> {
            return Observable.just("Test Title")
        }

    }

    private class Outputs: ShoppingsViewControllerOutputs {

        var addShoppingCalled = false

        // MARK: ShoppingsViewControllerOutputs

        func addShopping() {
            addShoppingCalled = true
        }

    }

}
