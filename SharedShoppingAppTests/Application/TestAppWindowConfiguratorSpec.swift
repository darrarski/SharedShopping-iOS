import Quick
import Nimble

@testable import SharedShoppingApp

class TestAppWindowConfiguratorSpec: QuickSpec {

    override func spec() {
        describe("TestAppWindowConfigurator") {
            var sut: TestAppWindowConfigurator!

            beforeEach {
                sut = TestAppWindowConfigurator()
            }

            context("configure window") {
                var windowSpy: UIWindowSpy!

                beforeEach {
                    windowSpy = UIWindowSpy()
                    sut.configureWindow(windowSpy)
                }

                it("should window have root view controller") {
                    expect(windowSpy.rootViewController).notTo(beNil())
                }

                it("should make window key and visible") {
                    expect(windowSpy.makeKeyAndVisibleCalled).to(beTrue())
                }
            }
        }
    }

}
