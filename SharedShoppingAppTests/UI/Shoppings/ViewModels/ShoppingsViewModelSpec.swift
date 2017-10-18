import Quick
import Nimble

@testable import SharedShoppingApp

class ShoppingsViewModelSpec: QuickSpec {

    override func spec() {
        describe("ShoppingsViewModel") {
            var sut: ShoppingsViewModel!
            var assembly: Assembly!

            beforeEach {
                assembly = Assembly()
                sut = ShoppingsViewModel(assembly: assembly)
            }

            it("should have correct title") {
                expect(sut.title).to(equal("Shared Shopping"))
            }

            context("add shopping") {
                beforeEach {
                    sut.addShopping()
                }

                it("should add shopping") {
                    expect(assembly.shoppingCreatorSpy.didCreateShopping).notTo(beNil())
                }
            }
        }
    }

    private struct Assembly: ShoppingsViewModelAssembly {

        let shoppingCreatorSpy = ShoppingCreatorSpy()

        // MARK: ShoppingsViewModelAssembly

        var shoppingCreator: ShoppingCreating {
            return shoppingCreatorSpy
        }

    }

}
