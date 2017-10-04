import Quick
import Nimble

@testable import SharedShoppingApp

class ListSpec: QuickSpec {

    override func spec() {
        describe("List") {
            var sut: List<Any>!

            beforeEach {
                sut = List()
            }

            describe("subscript get") {
                it("should throw assertion") {
                    expect { _ = sut[0] }.to(throwAssertion())
                }
            }

            describe("number of items") {
                it("should throw assertion") {
                    expect { _ = sut.numberOfItems }.to(throwAssertion())
                }
            }
        }
    }

}
