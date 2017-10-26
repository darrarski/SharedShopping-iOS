import Quick
import Nimble

@testable import SharedShoppingApp

class AppDelegateSpec: QuickSpec {

    override func spec() {
        describe("AppDelegate") {
            var sut: AppDelegate!
            var windowSpy: UIWindowSpy!

            beforeEach {
                windowSpy = UIWindowSpy()
                sut = AppDelegate()
                sut.windowFactory = { windowSpy }
            }

            context("application did finish launching") {
                var result: Bool!

                beforeEach {
                    result = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
                }

                it("should have window") {
                    expect(sut.window).notTo(beNil())
                }

                it("should use window from assembly") {
                    expect(sut.window).to(be(windowSpy))
                }

                it("should make window key and visible") {
                    expect(windowSpy.makeKeyAndVisibleCalled).to(beTrue())
                }

                it("should return true") {
                    expect(result).to(beTrue())
                }
            }
        }
    }

}
