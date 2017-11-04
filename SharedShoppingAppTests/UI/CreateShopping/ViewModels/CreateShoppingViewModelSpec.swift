import Quick
import Nimble

@testable import SharedShoppingApp

class CreateShoppingViewModelSpec: QuickSpec {

    override func spec() {
        describe("CreateShoppingViewModel") {
            var sut: CreateShoppingViewModel!
            var shoppingCreatorSpy: ShoppingCreatorSpy!

            beforeEach {
                shoppingCreatorSpy = ShoppingCreatorSpy()
                sut = CreateShoppingViewModel(shoppingCreator: shoppingCreatorSpy)
            }

            context("create shopping") {
                beforeEach {
                    sut.createShopping()
                }

                it("should create shopping") {
                    expect(shoppingCreatorSpy.didCreateShopping).notTo(beNil())
                }
            }
        }
    }

}
