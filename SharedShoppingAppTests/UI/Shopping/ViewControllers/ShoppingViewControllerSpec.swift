import Quick
import Nimble

@testable import SharedShoppingApp

class ShoppingViewControllerSpec: QuickSpec {

    override func spec() {
        describe("ShoppingViewController init with coder") {
            it("should throw fatal error") {
                onSimulator {
                    expect { _ = ShoppingViewController(coder: NSCoder()) }.to(throwAssertion())
                }
            }
        }

        describe("ShoppingViewController") {
            var sut: ShoppingViewController!

            beforeEach {
                sut = ShoppingViewController()
            }

            context("load view") {
                var view: UIView!

                beforeEach {
                    view = sut.view
                }

                it("should have white background") {
                    expect(view.backgroundColor).to(equal(.white))
                }
            }
        }
    }

}
