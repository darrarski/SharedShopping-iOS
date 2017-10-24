import Quick
import Nimble

@testable import SharedShoppingApp

class ShoppingsViewModelSpec: QuickSpec {

    override func spec() {
        describe("ShoppingsViewModel") {
            var sut: ShoppingsViewModel!
            var shoppingCreatorSpy: ShoppingCreatorSpy!

            beforeEach {
                shoppingCreatorSpy = ShoppingCreatorSpy()
                sut = ShoppingsViewModel(shoppingCreator: shoppingCreatorSpy)
            }

            it("should have correct title") {
                expect(sut.title).to(equal("Shared Shopping"))
            }

            context("add shopping") {
                beforeEach {
                    sut.addShopping()
                }

                it("should add shopping") {
                    expect(shoppingCreatorSpy.didCreateShopping).notTo(beNil())
                }
            }
        }
    }

}
