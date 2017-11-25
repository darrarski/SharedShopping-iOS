import Quick
import Nimble
import RxSwift
import RxBlocking
@testable import SharedShoppingApp

class ShoppingsViewModelSpec: QuickSpec {

    override func spec() {
        describe("ShoppingsViewModel") {
            var sut: ShoppingsViewModel!
            var createShoppingPresenterSpy: CreateShoppingPresenterSpy!

            beforeEach {
                createShoppingPresenterSpy = CreateShoppingPresenterSpy()
                sut = ShoppingsViewModel(createShoppingPresenter: createShoppingPresenterSpy)
            }

            it("should have correct title") {
                expect(try! sut.title.toBlocking().first()!).to(equal("Shared Shopping"))
            }

            context("add shopping") {
                beforeEach {
                    sut.addShopping()
                }

                it("should present Create Shopping") {
                    expect(createShoppingPresenterSpy.didPresentCreateShopping).to(beTrue())
                }
            }
        }
    }

}
