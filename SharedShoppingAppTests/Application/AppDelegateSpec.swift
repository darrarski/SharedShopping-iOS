import Quick
import Nimble

@testable import SharedShoppingApp

class AppDelegateSpec: QuickSpec {

    override func spec() {
        describe("AppDelegate") {
            var sut: AppDelegate!
            var assembly: AppDelegateAssemblyStub!

            beforeEach {
                assembly = AppDelegateAssemblyStub()
                sut = AppDelegate()
                sut.assembly = assembly
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
                    expect(sut.window).to(be(assembly.window))
                }

                it("should make window key and visible") {
                    expect(assembly.windowSpy.makeKeyAndVisibleCalled).to(beTrue())
                }

                it("should return true") {
                    expect(result).to(beTrue())
                }
            }
        }
    }

}
