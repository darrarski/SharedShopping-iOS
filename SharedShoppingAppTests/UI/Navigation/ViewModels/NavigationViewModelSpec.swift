import Quick
import Nimble

@testable import SharedShoppingApp

class NavigationViewModelSpec: QuickSpec {

    override func spec() {
        describe("NavigationViewModel") {
            var sut: NavigationViewModel!

            beforeEach {
                sut = NavigationViewModel()
            }

            it("should ") {
                expect(sut).notTo(beNil()) // TODO:
            }
        }
    }

}
