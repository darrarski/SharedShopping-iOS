import Quick
import Nimble

@testable import SharedShoppingApp

class MutableListSpec: QuickSpec {

    override func spec() {
        describe("MutableList") {
            var sut: MutableList<Any>!

            beforeEach {
                sut = MutableList()
            }

            describe("subscript get") {
                it("should throw assertion") {
                    expect { _ = sut[0] }.to(throwAssertion())
                }
            }

            describe("subscript set") {
                it("should throw assertion") {
                    expect { sut[0] = 0 }.to(throwAssertion())
                }
            }

            context("append") {
                it("should throw assertion") {
                    expect { sut.append(0) }.to(throwAssertion())
                }
            }
        }
    }

}
