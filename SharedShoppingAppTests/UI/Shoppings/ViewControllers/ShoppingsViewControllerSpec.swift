import Quick
import Nimble

@testable import SharedShoppingApp

class ShoppingsViewControllerSpec: QuickSpec {

    override func spec() {
        describe("ShoppingsViewController") {
            var sut: ShoppingsViewController!
            var tableViewController: UIViewController!
            var inputs: Inputs!
            var outputs: Outputs!

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

            context("load view") {
                beforeEach {
                    _ = sut.view
                }

                it("should embed tableViewController") {
                    expect(sut.childViewControllers).to(contain(tableViewController))
                }

                it("should have correct title") {
                    expect(sut.title).to(equal(inputs.title))
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

                        it("should call addShopping") {
                            expect(outputs.addShoppingCalled).to(beTrue())
                        }
                    }
                }
            }
        }
    }

    private class Inputs: ShoppingsViewControllerInputs {

        let title = "Test Title"

    }

    private class Outputs: ShoppingsViewControllerOutputs {

        var addShoppingCalled = false

        // MARK: ShoppingsViewControllerOutputs

        func addShopping() {
            addShoppingCalled = true
        }

    }

}
