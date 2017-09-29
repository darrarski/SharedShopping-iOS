import Quick
import Nimble

@testable import SharedShoppingApp

class ShoppingsViewControllerSpec: QuickSpec {

    override func spec() {
        describe("ShoppingsViewController init with coder") {
            it("should throw fatal error") {
                expect { _ = ShoppingsViewController(coder: NSCoder()) }.to(throwAssertion())
            }
        }

        describe("ShoppingsViewController") {
            var sut: ShoppingsViewController!

            beforeEach {
                sut = ShoppingsViewController()
            }

            it("should not be nil") { // TODO: remove
                expect(sut).notTo(beNil())
            }
        }
    }

}
