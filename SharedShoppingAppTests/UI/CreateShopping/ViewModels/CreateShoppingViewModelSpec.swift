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

            it("should have correct title") {
                expect(sut.title).to(equal("Shopping"))
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
                var selectShoppingNameTextObserver: SimpleTestableObserver<Void>!

                beforeEach {
                    startEditingObserver = SimpleTestableObserver<Void>()
                    selectShoppingNameTextObserver = SimpleTestableObserver<Void>()
                    _ = sut.startEditing.subscribe(startEditingObserver.observer)
                    _ = sut.selectShoppingNameText.subscribe(selectShoppingNameTextObserver.observer)
                    sut.viewDidAppear()
                }

                it("should start editing") {
                    expect(startEditingObserver.events).to(equal([Event<Void>.next(())]))
                }

                it("should select shopping name text") {
                    expect(selectShoppingNameTextObserver.events).to(equal([Event<Void>.next(())]))
                }

                context("view did appear again") {
                    beforeEach {
                        sut.viewDidAppear()
                    }

                    it("should start editing again") {
                        expect(startEditingObserver.events).to(equal([Event<Void>.next(()), Event<Void>.next(())]))
                    }

                    it("should not select shopping name text again") {
                        expect(selectShoppingNameTextObserver.events).to(equal([Event<Void>.next(())]))
                    }
                }
            }
        }
    }

}
