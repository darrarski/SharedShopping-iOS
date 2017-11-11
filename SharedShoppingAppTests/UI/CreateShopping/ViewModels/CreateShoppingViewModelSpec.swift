import Quick
import Nimble
import RxSwift

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

            context("view did appear") {
                var startEditingObserver: SimpleTestableObserver<Void>!

                beforeEach {
                    startEditingObserver = SimpleTestableObserver<Void>()
                    _ = sut.startEditing.subscribe(startEditingObserver.observer)
                    sut.viewDidAppear()
                }

                it("should start editing") {
                    expect(startEditingObserver.events).to(equal([Event<Void>.next(())]))
                }
            }
        }
    }

}
