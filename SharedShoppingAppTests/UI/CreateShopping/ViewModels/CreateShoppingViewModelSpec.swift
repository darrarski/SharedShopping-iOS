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
                expect(try! sut.title.toBlocking().first()!).to(equal("Shopping"))
            }

            it("should have correct shopping name") {
                expect(try! sut.shoppingName.toBlocking().first()!).to(equal("New Shopping"))
            }

            it("should have correct create button title") {
                expect(try! sut.createButtonTitle.toBlocking().first()!).to(equal("Create"))
            }

            context("clear shopping name") {
                beforeEach {
                    sut.shoppingNameDidChange(nil)
                }

                it("should create button be disabled") {
                    expect(try! sut.createButtonEnabled.toBlocking().first()!).to(beFalse())
                }

                context("set shopping name") {
                    beforeEach {
                        sut.shoppingNameDidChange("Name")
                    }

                    it("should create button be enabled") {
                        expect(try! sut.createButtonEnabled.toBlocking().first()!).to(beTrue())
                    }
                }

                context("create shopping") {
                    beforeEach {
                        sut.createShopping()
                    }

                    it("should not create shopping") {
                        expect(shoppingCreatorSpy.didCreateShopping).to(beNil())
                    }
                }
            }

            context("create shopping") {
                beforeEach {
                    sut.createShopping()
                }

                it("should create shopping") {
                    expect(shoppingCreatorSpy.didCreateShopping).notTo(beNil())
                }

                it("should created shopping have correct name") {
                    expect(shoppingCreatorSpy.didCreateShopping?.name)
                        .to(equal(try! sut.shoppingName.toBlocking().first()!))
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
