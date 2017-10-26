import Quick
import Nimble

@testable import SharedShoppingApp

class AppWindowFactorySpec: QuickSpec {

    override func spec() {
        describe("AppWindowFactory") {
            var sut: AppWindowFactory!
            var size: CGSize!

            beforeEach {
                size = CGSize(width: 100, height: 200)
                sut = AppWindowFactory(size: size)
            }

            context("create app window") {
                var window: UIWindow!

                beforeEach {
                    window = sut.createAppWindow()
                }

                it("should window have correct size") {
                    expect(window.frame.size).to(equal(size))
                }
            }
        }
    }

}
