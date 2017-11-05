import Quick
import Nimble

@testable import SharedShoppingApp

class CreateShoppingViewControllerSpec: QuickSpec {

    override func spec() {
        describe("CreateShoppingViewController") {
            var sut: CreateShoppingViewController!
            var outputs: Outputs!

            beforeEach {
                outputs = Outputs()
                sut = CreateShoppingViewController(
                    scrollViewController: ScrollViewController(
                        keyboardListener: KeyboardFrameChangeListenerMock(),
                        scrollViewKeyboardAvoider: ScrollViewKeyboardAvoiderSpy()
                    ),
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
            }
        }
    }

    private class Outputs: CreateShoppingViewControllerOutputs {

        var didCreateShopping = false

        // MARK: CreateShoppingViewControllerOutputs

        func createShopping() {
            didCreateShopping = true
        }

    }

}
