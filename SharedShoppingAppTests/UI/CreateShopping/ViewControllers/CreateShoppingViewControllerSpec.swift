import Quick
import Nimble

@testable import SharedShoppingApp

class CreateShoppingViewControllerSpec: QuickSpec {

    override func spec() {
        describe("CreateShoppingViewController") {
            var sut: CreateShoppingViewController!

            beforeEach {
                sut = CreateShoppingViewController()
            }

            context("load view") {
                beforeEach {
                    _ = sut.view
                }

                it("should view have white background") {
                    expect(sut.view.backgroundColor).to(equal(UIColor.white))
                }
            }
        }
    }

}
