import Quick
import Nimble
import RxSwift
import RxTest
import RxBlocking

@testable import SharedShoppingApp

class ShoppingsTableViewModelSpec: QuickSpec {

    override func spec() {
        describe("ShoppingsTableViewModel") {
            var sut: ShoppingsTableViewModel!
            var shoppingsProviderStub: ShoppingsProviderStub!

            beforeEach {
                shoppingsProviderStub = ShoppingsProviderStub()
                shoppingsProviderStub.shoppingsVar.value = [
                    ShoppingFake(name: "Shopping 1", date: Date()),
                    ShoppingFake(name: "Shopping 2", date: Date()),
                    ShoppingFake(name: "Shopping 3", date: Date()),
                    ShoppingFake(name: "Shopping 4", date: Date())
                ]
                sut = ShoppingsTableViewModel(
                    shoppingsProvider: shoppingsProviderStub,
                    rowViewModelFactory: { TableRowViewModelStub(uid: $0.name) }
                )
            }

            it("should have four row view models") {
                expect(try! sut.rowViewModels.toBlocking().first()).to(haveCount(4))
            }

            describe("first row view model") {
                var rowViewModel: TableRowViewModel!

                beforeEach {
                    rowViewModel = try! sut.rowViewModels.toBlocking().first()?.first
                }

                it("should be a stub") {
                    expect(rowViewModel).to(beAKindOf(TableRowViewModelStub.self))
                }

                it("should have correct shopping") {
                    expect((rowViewModel as? TableRowViewModelStub)?.uid)
                        .to(equal(shoppingsProviderStub.shoppingsVar.value.first!.name))
                }
            }

            context("remove last Shopping") {
                beforeEach {
                    shoppingsProviderStub.shoppingsVar.value.removeLast()
                }

                it("should have three row view models") {
                    expect(try! sut.rowViewModels.toBlocking().first()).to(haveCount(3))
                }

                context("insert shopping at index 0") {
                    beforeEach {
                        let shopping = ShoppingFake(name: "Inserted Shopping", date: Date())
                        shoppingsProviderStub.shoppingsVar.value.insert(shopping, at: 0)
                    }

                    it("should have four row view models") {
                        expect(try! sut.rowViewModels.toBlocking().first()).to(haveCount(4))
                    }
                }
            }
        }
    }

}
