import Quick
import Nimble

@testable import SharedShoppingApp

class ShoppingViewControllerSpec: QuickSpec {

    override func spec() {
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
