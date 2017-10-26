import Quick
import Nimble

@testable import SharedShoppingApp

class AppDelegateSpec: QuickSpec {

    override func spec() {
        describe("AppDelegate") {
            var sut: AppDelegate!
            var appWindowFactoryStub: AppWindowFactoryStub!
            var appWindowConfiguratorSpy: AppWindowConfiguratorSpy!

            beforeEach {
                appWindowFactoryStub = AppWindowFactoryStub()
                appWindowConfiguratorSpy = AppWindowConfiguratorSpy()
                sut = AppDelegate()
                sut.appWindowFactory = appWindowFactoryStub
                sut.appWindowConfigurator = appWindowConfiguratorSpy
            }

            context("application did finish launching") {
                var result: Bool!

                beforeEach {
                    result = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
                }

                it("should have window") {
                    expect(sut.window).notTo(beNil())
                }

                it("should have correct window") {
                    expect(sut.window).to(be(appWindowFactoryStub.windowSpy))
                }

                it("should configure window") {
                    expect(appWindowConfiguratorSpy.didConfigureWindow).to(be(sut.window))
                }

                it("should return true") {
                    expect(result).to(beTrue())
                }
            }
        }
    }

}
