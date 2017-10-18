import Quick
import Nimble

@testable import SharedShoppingApp

class ShoppingServiceSpec: QuickSpec {

    override func spec() {
        describe("ShoppingService") {
            var sut: ShoppingService!

            beforeEach {
                sut = ShoppingService()
            }

            it("should have no shoppings") {
                expect(sut.shoppings()).to(beEmpty())
            }

            context("create shopping") {
                var createdShopping: Shopping!

                beforeEach {
                    createdShopping = sut.createShopping()
                }

                it("should have created shopping") {
                    expect(sut.shoppings()).to(contain(createdShopping))
                }

                context("remove created shopping") {
                    beforeEach {
                        sut.removeShopping(createdShopping)
                    }

                    it("should have no shoppings") {
                        expect(sut.shoppings()).to(beEmpty())
                    }
                }

                context("remove other shopping") {
                    beforeEach {
                        sut.removeShopping(Shopping(name: "Other Shopping", date: Date()))
                    }

                    it("should have created shopping") {
                        expect(sut.shoppings()).to(contain(createdShopping))
                    }
                }
            }
        }
    }

}
