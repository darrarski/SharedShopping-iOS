import Quick
import Nimble
@testable import SharedShoppingApp

class CreateShoppingViewSpec: QuickSpec {

    override func spec() {
        describe("CreateShoppingView") {
            var sut: CreateShoppingView!

            context("init with coder") {
                beforeEach {
                    sut = CreateShoppingView(coder: NSCoder())
                }

                it("should be nil") {
                    expect(sut).to(beNil())
                }
            }
        }
    }

}
