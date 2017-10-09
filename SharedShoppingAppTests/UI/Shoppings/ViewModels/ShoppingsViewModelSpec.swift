import Quick
import Nimble

@testable import SharedShoppingApp

class ShoppingsViewModelSpec: QuickSpec {

    override func spec() {
        describe("ShoppingsViewModel") {
            var sut: ShoppingsViewModel!

            beforeEach {
                sut = ShoppingsViewModel()
            }

            it("should have correct title") {
                expect(sut.title).to(equal("Shared Shopping"))
            }
        }
    }

}
