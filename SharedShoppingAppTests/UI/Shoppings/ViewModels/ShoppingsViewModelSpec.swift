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

                // TODO: test "add shopping" action
            }
        }
    }

    private struct Assembly: ShoppingsViewModelAssembly {

    }

}
