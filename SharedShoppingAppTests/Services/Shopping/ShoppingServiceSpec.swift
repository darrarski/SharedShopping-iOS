import Quick
import Nimble
import RxSwift
import RxBlocking

@testable import SharedShoppingApp

class ShoppingServiceSpec: QuickSpec {

    override func spec() {
        describe("ShoppingService") {
            var sut: ShoppingService!

            beforeEach {
                sut = ShoppingService()
            }

            it("should have no shoppings") {
                expect { try sut.shoppings.toBlocking().first() }.to(beEmpty())
            }

            context("create shopping") {
                var createdShopping: Shopping!

                beforeEach {
                    createdShopping = sut.createShopping()
                }

                it("should have created shopping") {
                    expect { try sut.shoppings.toBlocking().first() }.to(contain(createdShopping))
                }

                context("remove created shopping") {
                    beforeEach {
                        sut.removeShopping(createdShopping)
                    }

                    it("should have no shoppings") {
                        expect { try sut.shoppings.toBlocking().first() }.to(beEmpty())
                    }
                }

                context("remove other shopping") {
                    beforeEach {
                        sut.removeShopping(ShoppingFake(name: "Other Shopping", date: Date()))
                    }

                    it("should have created shopping") {
                        expect { try sut.shoppings.toBlocking().first() }.to(contain(createdShopping))
                    }
                }
            }
        }
    }

}
