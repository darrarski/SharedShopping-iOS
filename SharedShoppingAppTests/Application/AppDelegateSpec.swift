import Quick
import Nimble

@testable import SharedShoppingApp

class AppDelegateSpec: QuickSpec {

    override func spec() {
        describe("AppDelegate") {
            var sut: AppDelegate!
            var assembly: Assembly!

            beforeEach {
                assembly = Assembly()
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

    private class Assembly: AppDelegateAssembly {

        let windowSpy = WindowSpy()

        // MARK: AppDelegateAssembly

        var window: UIWindow {
            return windowSpy
        }

    }

    private class WindowSpy: UIWindow {

        var makeKeyAndVisibleCalled = false

        override func makeKeyAndVisible() {
            makeKeyAndVisibleCalled = true
        }

    }
}
