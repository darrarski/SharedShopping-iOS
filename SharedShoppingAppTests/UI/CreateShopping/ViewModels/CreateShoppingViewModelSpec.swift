import Quick
import Nimble

@testable import SharedShoppingApp

class CreateShoppingViewModelSpec: QuickSpec {

    override func spec() {
        describe("CreateShoppingViewModel") {
            var sut: CreateShoppingViewModel!
            var shoppingCreatorSpy: ShoppingCreatorSpy!
            var createdShoppingPresenterSpy: CreatedShoppingPresenterSpy!

            beforeEach {
                shoppingCreatorSpy = ShoppingCreatorSpy()
                createdShoppingPresenterSpy = CreatedShoppingPresenterSpy()
                sut = CreateShoppingViewModel(
                    shoppingCreator: shoppingCreatorSpy,
                    createdShoppingPresenter: createdShoppingPresenterSpy
                )
            }

            context("create shopping") {
                beforeEach {
                    sut.createShopping()
                }

                it("should create shopping") {
                    expect(shoppingCreatorSpy.didCreateShopping).notTo(beNil())
                }

                it("should present created shopping") {
                    expect(createdShoppingPresenterSpy.didPresentCreatedShopping)
                        .to(equal(shoppingCreatorSpy.didCreateShopping))
                }
            }
        }
    }

}
